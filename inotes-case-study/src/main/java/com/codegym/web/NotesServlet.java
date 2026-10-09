package com.codegym.web;

import com.codegym.model.Note;
import com.codegym.model.NoteType;
import com.codegym.service.NoteManagement;
import com.codegym.storage.NoteDBStrategy;
import com.codegym.storage.NoteFileStrategy;
import com.codegym.storage.NoteStrategy;
import com.codegym.storage.StorageException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * MVC controller: note CRUD, keyword search, category filter and runtime strategy selection.
 * Mutations are POST-only and guarded with a per-session CSRF token.
 */
@WebServlet(name = "NotesServlet", urlPatterns = "/notes")
public class NotesServlet extends HttpServlet {
    private NoteManagement manager;
    private NoteStrategy fileStrategy;
    private NoteStrategy dbStrategy;

    @Override
    public void init() {
        fileStrategy = new NoteFileStrategy();
        dbStrategy = new NoteDBStrategy();
        // File mode works immediately, even if MySQL has not yet been configured.
        manager = new NoteManagement(fileStrategy);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        prepareCsrf(req);
        try {
            switch (value(req.getParameter("action"))) {
                case "create" -> showForm(req, resp, null);
                case "edit" -> {
                    Note note = manager.getNote(parsePositive(req.getParameter("id")))
                            .orElse(null);
                    if (note == null) resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    else showForm(req, resp, note);
                }
                case "view" -> {
                    Note note = manager.getNote(parsePositive(req.getParameter("id")))
                            .orElse(null);
                    if (note == null) resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    else {
                        req.setAttribute("note", note);
                        req.setAttribute("typeNames", getTypeNames());
                        req.setAttribute("storageName", manager.getStorageName());
                        render(req, resp, "/WEB-INF/views/detail.jsp");
                    }
                }
                default -> showList(req, resp);
            }
        } catch (NumberFormatException ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        } catch (StorageException ex) {
            showStorageError(req, resp, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        if (!checkCsrf(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Phiên làm việc không hợp lệ");
            return;
        }
        try {
            switch (value(req.getParameter("action"))) {
                case "save" -> save(req, resp);
                case "delete" -> {
                    int id = parsePositive(req.getParameter("id"));
                    if (!manager.deleteNote(id)) resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    else redirect(req, resp, "deleted");
                }
                case "switch" -> {
                    String mode = value(req.getParameter("mode"));
                    NoteStrategy candidate;
                    if ("file".equals(mode)) candidate = fileStrategy;
                    else if ("mysql".equals(mode)) candidate = dbStrategy;
                    else {
                        resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                        return;
                    }
                    // Validate backend availability before changing the global strategy.
                    candidate.findTypes();
                    candidate.findAll();
                    manager.setStrategy(candidate);
                    redirect(req, resp, "switched");
                }
                default -> resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (NumberFormatException ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu số không hợp lệ");
        } catch (StorageException ex) {
            showStorageError(req, resp, ex);
        }
    }

    private void save(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id;
        int typeId;
        try {
            String rawId = value(req.getParameter("id"));
            id = rawId.isEmpty() ? 0 : Integer.parseInt(rawId);
            if (id < 0) throw new NumberFormatException("Negative ID");
            typeId = parsePositive(req.getParameter("typeId"));
        } catch (NumberFormatException ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID hoặc phân loại không hợp lệ");
            return;
        }

        String title = value(req.getParameter("title"));
        String content = value(req.getParameter("content"));
        try {
            if (id == 0) manager.addNote(title, content, typeId);
            else manager.updateNote(id, title, content, typeId);
            redirect(req, resp, id == 0 ? "created" : "updated");
        } catch (IllegalArgumentException ex) {
            Note note = new Note(id, title, content, typeId);
            req.setAttribute("formError", ex.getMessage());
            showForm(req, resp, note);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = value(req.getParameter("q")).strip();
        if (keyword.length() > 255) keyword = keyword.substring(0, 255);
        String type = value(req.getParameter("type"));
        int selectedType;
        try {
            selectedType = type.isEmpty() ? 0 : Integer.parseInt(type);
        } catch (NumberFormatException ex) {
            selectedType = 0;
        }
        final int filterType = selectedType;
        List<Note> notes = manager.searchNotes(keyword);
        if (filterType > 0) {
            notes = notes.stream().filter(note -> note.getTypeId() == filterType).toList();
        }
        req.setAttribute("notes", notes);
        req.setAttribute("keyword", keyword);
        req.setAttribute("selectedType", selectedType);
        req.setAttribute("types", manager.listTypes());
        req.setAttribute("typeNames", getTypeNames());
        req.setAttribute("storageName", manager.getStorageName());
        req.setAttribute("storageMode", manager.getStrategy() == fileStrategy ? "file" : "mysql");
        render(req, resp, "/WEB-INF/views/list.jsp");
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp, Note note)
            throws ServletException, IOException {
        req.setAttribute("note", note == null ? new Note() : note);
        req.setAttribute("editing", note != null && note.getId() > 0);
        req.setAttribute("types", manager.listTypes());
        req.setAttribute("storageName", manager.getStorageName());
        render(req, resp, "/WEB-INF/views/form.jsp");
    }

    private Map<Integer, String> getTypeNames() {
        Map<Integer, String> names = new LinkedHashMap<>();
        for (NoteType type : manager.listTypes()) names.put(type.getId(), type.getName());
        return names;
    }

    private void showStorageError(HttpServletRequest req, HttpServletResponse resp, StorageException ex)
            throws ServletException, IOException {
        getServletContext().log("iNotes storage error", ex);
        prepareCsrf(req); // Recovery form can switch back to File even after a failed POST.
        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        req.setAttribute("storageError", ex.getMessage());
        req.setAttribute("storageName", manager.getStorageName());
        render(req, resp, "/WEB-INF/views/error.jsp");
    }

    private void prepareCsrf(HttpServletRequest req) {
        HttpSession session = req.getSession();
        String csrf = (String) session.getAttribute("inotesCsrf");
        if (csrf == null) {
            csrf = UUID.randomUUID().toString();
            session.setAttribute("inotesCsrf", csrf);
        }
        req.setAttribute("csrf", csrf);
    }

    private boolean checkCsrf(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return false;
        Object token = session.getAttribute("inotesCsrf");
        return token instanceof String && token.equals(req.getParameter("_csrf"));
    }

    private static int parsePositive(String raw) {
        int id = Integer.parseInt(value(raw));
        if (id < 1) throw new NumberFormatException("Expected positive integer");
        return id;
    }

    private static String value(String input) { return input == null ? "" : input; }

    private void redirect(HttpServletRequest req, HttpServletResponse resp, String message)
            throws IOException {
        resp.sendRedirect(req.getContextPath() + "/notes?notice=" + message);
    }

    private void render(HttpServletRequest req, HttpServletResponse resp, String jsp)
            throws ServletException, IOException {
        req.getRequestDispatcher(jsp).forward(req, resp);
    }
}
