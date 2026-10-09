package com.codegym.storage;

import com.codegym.model.Note;
import com.codegym.service.NoteManagement;
import java.nio.file.Files;
import java.nio.file.Path;

/** No-dependency test; run with java after compiling sources with javac. */
public final class NoteFileStrategySelfTest {
    private static void check(boolean ok, String why) {
        if (!ok) throw new AssertionError(why);
    }
    public static void main(String[] args) throws Exception {
        Path directory = Files.createTempDirectory("inotes-test-");
        Path path = directory.resolve("notes.txt");
        try {
            NoteManagement manager = new NoteManagement(new NoteFileStrategy(path));
            Note note = manager.addNote("Kiểm tra | dấu", "Dòng 1\nDòng 2|dấu\\gạch", 3);
            check(note.getId() == 1, "id sequence");
            check(manager.listNotes().size() == 1, "saved note count");
            check(manager.searchNotes("Dòng 2").size() == 1, "search content");
            check(Files.readString(path).contains("\\|"), "pipe escape");
            NoteManagement loaded = new NoteManagement(new NoteFileStrategy(path));
            check(loaded.getNote(1).orElseThrow().getContent().equals("Dòng 1\nDòng 2|dấu\\gạch"), "persist escaped text");
            loaded.updateNote(1, "Tiêu đề sửa", "Mới", 2);
            check(loaded.searchNotes("Tiêu đề sửa").size() == 1, "update and search");
            check(loaded.deleteNote(1), "delete");
            check(loaded.listNotes().isEmpty(), "empty after deletion");
            check(!loaded.deleteNote(1), "nonexistent delete returns false");
            check(loaded.listTypes().size() == 3, "three types");
            try {
                loaded.addNote("   ", "", 1);
                throw new AssertionError("empty title should fail");
            } catch (IllegalArgumentException expected) {
                // Expected.
            }
            System.out.println("PASS: File Strategy save / reload / search / update / delete / escapes");
        } finally {
            Files.deleteIfExists(path);
            Files.deleteIfExists(directory);
        }
    }
}
