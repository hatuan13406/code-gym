package com.codegym.storage;

import com.codegym.model.Note;
import com.codegym.model.NoteType;
import java.util.List;
import java.util.Optional;

/** Strategy contract shared by database and text-file storage. */
public interface NoteStrategy {
    void save(Note note);
    boolean delete(int id);
    List<Note> findAll();
    List<Note> search(String keyword);
    Optional<Note> findById(int id);
    List<NoteType> findTypes();
    String name();
}
