package com.codegym.service;

import com.codegym.model.Note;
import com.codegym.model.NoteType;
import com.codegym.storage.NoteStrategy;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

/** Application/service layer: controllers never need to know how notes are stored. */
public class NoteManagement {
    private volatile NoteStrategy strategy;

    public NoteManagement(NoteStrategy initialStrategy) {
        setStrategy(initialStrategy);
    }

    /** Swap persistence implementation at runtime; existing backends keep their own data. */
    public synchronized void setStrategy(NoteStrategy strategy) {
        this.strategy = Objects.requireNonNull(strategy, "strategy");
    }

    public NoteStrategy getStrategy() { return strategy; }
    public String getStorageName() { return strategy.name(); }
    public List<Note> listNotes() { return strategy.findAll(); }
    public List<NoteType> listTypes() { return strategy.findTypes(); }
    public Optional<Note> getNote(int id) { return strategy.findById(id); }

    public List<Note> searchNotes(String keyword) {
        return strategy.search(keyword);
    }

    public Note addNote(String title, String content, int typeId) {
        NoteStrategy active = strategy;
        validate(active, title, content, typeId);
        Note note = new Note(title.strip(), content == null ? "" : content, typeId);
        note.setStorage(active);
        note.save();
        return note;
    }

    public Note updateNote(int id, String title, String content, int typeId) {
        NoteStrategy active = strategy;
        validate(active, title, content, typeId);
        if (id <= 0 || active.findById(id).isEmpty()) {
            throw new IllegalArgumentException("Không tìm thấy ghi chú cần sửa");
        }
        Note note = new Note(id, title.strip(), content == null ? "" : content, typeId);
        note.setStorage(active);
        note.save();
        return note;
    }

    public boolean deleteNote(int id) {
        if (id <= 0) return false;
        Note note = new Note();
        note.setStorage(strategy);
        return note.delete(id);
    }

    private static void validate(NoteStrategy active, String title, String content, int typeId) {
        if (title == null || title.isBlank() || title.strip().length() > 255) {
            throw new IllegalArgumentException("Tiêu đề phải từ 1 đến 255 ký tự");
        }
        if (content != null && content.length() > 20000) {
            throw new IllegalArgumentException("Nội dung tối đa 20.000 ký tự");
        }
        if (active.findTypes().stream().noneMatch(t -> t.getId() == typeId)) {
            throw new IllegalArgumentException("Phân loại không hợp lệ");
        }
    }
}
