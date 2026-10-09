package com.codegym.storage;

import com.codegym.model.Note;
import com.codegym.model.NoteType;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Locale;

/** JDBC MySQL implementation: parameterized queries prevent SQL injection. */
public class NoteDBStrategy implements NoteStrategy {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/inotes_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
    private final String url;
    private final String username;
    private final String password;

    public NoteDBStrategy() {
        this(System.getenv().getOrDefault("INOTES_DB_URL", DEFAULT_URL),
                System.getenv().getOrDefault("INOTES_DB_USER", "root"),
                System.getenv().getOrDefault("INOTES_DB_PASSWORD", ""));
    }

    public NoteDBStrategy(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    private Connection open() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    private Note mapNote(ResultSet rs) throws SQLException {
        return new Note(rs.getInt("id"), rs.getString("title"),
                rs.getString("content"), rs.getInt("type_id"));
    }

    @Override
    public void save(Note note) {
        if (note.getId() == 0) {
            String sql = "INSERT INTO notes (title, content, type_id) VALUES (?, ?, ?)";
            try (Connection connection = open();
                 PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, note.getTitle());
                ps.setString(2, note.getContent());
                ps.setInt(3, note.getTypeId());
                if (ps.executeUpdate() != 1) throw new StorageException("Unable to insert note");
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (!keys.next()) throw new StorageException("MySQL did not return the new note ID");
                    note.setId(keys.getInt(1));
                }
            } catch (SQLException ex) {
                throw new StorageException("Cannot insert note in MySQL", ex);
            }
        } else {
            String sql = "UPDATE notes SET title=?, content=?, type_id=? WHERE id=?";
            try (Connection connection = open(); PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, note.getTitle());
                ps.setString(2, note.getContent());
                ps.setInt(3, note.getTypeId());
                ps.setInt(4, note.getId());
                if (ps.executeUpdate() != 1) throw new StorageException("Note not found for update");
            } catch (SQLException ex) {
                throw new StorageException("Cannot update note in MySQL", ex);
            }
        }
    }

    @Override
    public boolean delete(int id) {
        try (Connection connection = open();
             PreparedStatement ps = connection.prepareStatement("DELETE FROM notes WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new StorageException("Cannot delete note in MySQL", ex);
        }
    }

    @Override
    public List<Note> findAll() {
        String sql = "SELECT id, title, content, type_id FROM notes ORDER BY id DESC";
        try (Connection connection = open();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Note> notes = new ArrayList<>();
            while (rs.next()) notes.add(mapNote(rs));
            return notes;
        } catch (SQLException ex) {
            throw new StorageException("Cannot load notes from MySQL", ex);
        }
    }

    @Override
    public List<Note> search(String keyword) {
        String cleaned = keyword == null ? "" : keyword.strip();
        if (cleaned.isEmpty()) return findAll();
        String sql = "SELECT id, title, content, type_id FROM notes "
                + "WHERE LOWER(title) LIKE ? ESCAPE '!' "
                + "OR LOWER(COALESCE(content,'')) LIKE ? ESCAPE '!' ORDER BY id DESC";
        // Treat %, _ and ! from the user as literal characters, not SQL wildcards.
        String escaped = cleaned.toLowerCase(Locale.ROOT)
                .replace("!", "!!").replace("%", "!%").replace("_", "!_");
        try (Connection connection = open(); PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + escaped + "%");
            ps.setString(2, "%" + escaped + "%");
            try (ResultSet rs = ps.executeQuery()) {
                List<Note> notes = new ArrayList<>();
                while (rs.next()) notes.add(mapNote(rs));
                return notes;
            }
        } catch (SQLException ex) {
            throw new StorageException("Cannot search notes in MySQL", ex);
        }
    }

    @Override
    public Optional<Note> findById(int id) {
        try (Connection connection = open();
             PreparedStatement ps = connection.prepareStatement(
                     "SELECT id, title, content, type_id FROM notes WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? Optional.of(mapNote(rs)) : Optional.empty();
            }
        } catch (SQLException ex) {
            throw new StorageException("Cannot find note in MySQL", ex);
        }
    }

    @Override
    public List<NoteType> findTypes() {
        try (Connection connection = open();
             PreparedStatement ps = connection.prepareStatement(
                     "SELECT id, name, description FROM note_type ORDER BY id");
             ResultSet rs = ps.executeQuery()) {
            List<NoteType> types = new ArrayList<>();
            while (rs.next()) {
                types.add(new NoteType(rs.getInt("id"), rs.getString("name"), rs.getString("description")));
            }
            return types;
        } catch (SQLException ex) {
            throw new StorageException("Cannot load note categories from MySQL; run database.sql first", ex);
        }
    }

    @Override
    public String name() { return "MySQL"; }
}
