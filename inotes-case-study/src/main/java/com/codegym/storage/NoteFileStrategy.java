package com.codegym.storage;

import com.codegym.model.Note;
import com.codegym.model.NoteType;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.AtomicMoveNotSupportedException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

/**
 * Persistent text-file strategy, one UTF-8 record per line:
 * id|title|content|typeId.
 *
 * Escapes: \\ for backslash, \| for pipe, \n and \r for newlines.
 * All operations synchronize on this strategy instance; writes are atomic.
 */
public class NoteFileStrategy implements NoteStrategy {
    private final Path file;
    private static final List<NoteType> TYPES = List.of(
            new NoteType(1, "Cá nhân", "Ghi chú cá nhân"),
            new NoteType(2, "Công việc", "Công việc và lịch trình"),
            new NoteType(3, "Học tập", "Kiến thức và bài học"));

    public NoteFileStrategy() {
        this(Path.of(System.getenv().getOrDefault("INOTES_FILE_PATH",
                Path.of(System.getProperty("user.home"), ".inotes", "notes.txt").toString())));
    }

    public NoteFileStrategy(Path path) {
        file = path.toAbsolutePath().normalize();
    }

    public Path getFile() { return file; }

    @Override
    public synchronized void save(Note note) {
        List<Note> notes = readAll();
        if (note.getId() <= 0) {
            int nextId = notes.stream().mapToInt(Note::getId).max().orElse(0) + 1;
            note.setId(nextId);
            notes.add(copy(note));
        } else {
            int index = -1;
            for (int i = 0; i < notes.size(); i++) {
                if (notes.get(i).getId() == note.getId()) {
                    index = i;
                    break;
                }
            }
            if (index < 0) throw new StorageException("Note not found for update");
            notes.set(index, copy(note));
        }
        writeAll(notes);
    }

    @Override
    public synchronized boolean delete(int id) {
        List<Note> notes = readAll();
        boolean changed = notes.removeIf(note -> note.getId() == id);
        if (changed) writeAll(notes);
        return changed;
    }

    @Override
    public synchronized List<Note> findAll() {
        List<Note> notes = readAll();
        notes.sort(Comparator.comparingInt(Note::getId).reversed());
        return notes;
    }

    @Override
    public synchronized List<Note> search(String keyword) {
        String term = keyword == null ? "" : keyword.strip().toLowerCase(Locale.ROOT);
        if (term.isEmpty()) return findAll();
        return findAll().stream().filter(note ->
                note.getTitle().toLowerCase(Locale.ROOT).contains(term) ||
                (note.getContent() != null && note.getContent().toLowerCase(Locale.ROOT).contains(term)))
                .toList();
    }

    @Override
    public synchronized Optional<Note> findById(int id) {
        return readAll().stream().filter(note -> note.getId() == id).findFirst();
    }

    @Override
    public List<NoteType> findTypes() { return TYPES; }

    @Override
    public String name() { return "File TXT"; }

    private static Note copy(Note note) {
        return new Note(note.getId(), note.getTitle(), note.getContent(), note.getTypeId());
    }

    private List<Note> readAll() {
        if (!Files.exists(file)) return new ArrayList<>();
        try {
            List<Note> notes = new ArrayList<>();
            int row = 0;
            for (String line : Files.readAllLines(file, StandardCharsets.UTF_8)) {
                row++;
                if (line.isBlank()) continue;
                List<String> fields = parse(line);
                if (fields.size() != 4) {
                    throw new StorageException("Invalid notes file at line " + row + ": expected four fields");
                }
                try {
                    int id = Integer.parseInt(fields.get(0));
                    int typeId = Integer.parseInt(fields.get(3));
                    if (id <= 0 || typeId <= 0) throw new NumberFormatException("non-positive identifier");
                    notes.add(new Note(id, fields.get(1), fields.get(2), typeId));
                } catch (NumberFormatException ex) {
                    throw new StorageException("Invalid numeric note field at line " + row, ex);
                }
            }
            return notes;
        } catch (IOException ex) {
            throw new StorageException("Cannot read notes from file: " + file, ex);
        }
    }

    private void writeAll(List<Note> notes) {
        Path temp = null;
        try {
            Path dir = file.getParent();
            if (dir == null) throw new StorageException("Invalid notes file path");
            Files.createDirectories(dir);
            temp = Files.createTempFile(dir, "inotes-", ".tmp");
            List<String> lines = new ArrayList<>();
            for (Note n : notes) {
                lines.add(n.getId() + "|" + escape(n.getTitle()) + "|"
                        + escape(n.getContent()) + "|" + n.getTypeId());
            }
            Files.write(temp, lines, StandardCharsets.UTF_8);
            try {
                Files.move(temp, file, StandardCopyOption.ATOMIC_MOVE, StandardCopyOption.REPLACE_EXISTING);
            } catch (AtomicMoveNotSupportedException unsupported) {
                Files.move(temp, file, StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (IOException ex) {
            throw new StorageException("Cannot persist notes to file: " + file, ex);
        } finally {
            if (temp != null) {
                try { Files.deleteIfExists(temp); } catch (IOException ignored) { /* best effort */ }
            }
        }
    }

    private static String escape(String input) {
        String value = input == null ? "" : input;
        return value.replace("\\", "\\\\").replace("|", "\\|")
                .replace("\n", "\\n").replace("\r", "\\r");
    }

    private static List<String> parse(String line) {
        List<String> values = new ArrayList<>();
        StringBuilder field = new StringBuilder();
        for (int i = 0; i < line.length(); i++) {
            char ch = line.charAt(i);
            if (ch == '|') {
                values.add(field.toString());
                field.setLength(0);
            } else if (ch == '\\') {
                if (++i >= line.length()) throw new StorageException("Invalid trailing escape in notes file");
                char escaped = line.charAt(i);
                switch (escaped) {
                    case 'n' -> field.append('\n');
                    case 'r' -> field.append('\r');
                    case '|' -> field.append('|');
                    case '\\' -> field.append('\\');
                    default -> throw new StorageException("Unknown escape in notes file");
                }
            } else {
                field.append(ch);
            }
        }
        values.add(field.toString());
        return values;
    }
}
