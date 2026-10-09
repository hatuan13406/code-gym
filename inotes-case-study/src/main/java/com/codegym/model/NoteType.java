package com.codegym.model;

/** Category metadata stored in note_type in database mode. */
public class NoteType {
    private final int id;
    private final String name;
    private final String description;

    public NoteType(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }
    public int getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
}
