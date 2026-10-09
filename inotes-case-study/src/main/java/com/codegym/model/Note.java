package com.codegym.model;

import com.codegym.storage.NoteStrategy;
import java.util.Objects;

/** A single personal note. Persistence is delegated to a pluggable strategy. */
public class Note {
    private int id;
    private String title;
    private String content;
    private int typeId;
    private transient NoteStrategy storage;

    public Note() {}

    public Note(int id, String title, String content, int typeId) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.typeId = typeId;
    }

    public Note(String title, String content, int typeId) {
        this(0, title, content, typeId);
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public int getTypeId() { return typeId; }
    public void setTypeId(int typeId) { this.typeId = typeId; }

    public void setStorage(NoteStrategy storage) {
        this.storage = Objects.requireNonNull(storage, "storage");
    }

    /** Saves a new note or updates an existing one through the selected strategy. */
    public void save() {
        if (storage == null) throw new IllegalStateException("No NoteStrategy configured");
        storage.save(this);
    }

    /** Deletes the specified note through the selected strategy. */
    public boolean delete(int id) {
        if (storage == null) throw new IllegalStateException("No NoteStrategy configured");
        return storage.delete(id);
    }
}
