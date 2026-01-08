import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/data/model/notes.dart';
import 'package:map_exam/data/repository/notes.dart';

class NotesViewModel extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final NoteRepository _noteRepository = NoteRepository();

  // Fetch notes for the logged-in user
  Future<void> fetchNotes() async {
    print("Fetching notes for user...");
    _notes = await _noteRepository.getNotes();
    print("notes $notes");
    notifyListeners();
  }

  Note? getNoteById(String noteId) {
    try {
      return _notes.firstWhere((note) => note.id == noteId);
    } catch (e) {
      return null; // Return null if no note is found with the given ID
    }
  }

  // Add a new note
  Future<void> addNote(String title, String content) async {
    final String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get the current user's UID

    Note newNote = Note(id: '', title: title, content: content, userId: userId);

    try {
      await _noteRepository.addNote(newNote);
      await fetchNotes(); // Re-fetch notes to update the local list
    } catch (e) {
      print("Error adding note: $e");
    }

    await fetchNotes();
  }

  // Update an existing note
  Future<void> updateNote(String id, String newTitle, String newContent) async {
    try {
      final existingNote = getNoteById(id);
      if (existingNote != null) {
        // Create a new Note with the updated content
        final updatedNote = Note(
          id: id,
          title: newTitle,
          content: newContent,
          userId: existingNote.userId,
        );

        await _noteRepository.updateNote(id, updatedNote);
        await fetchNotes(); // Re-fetch notes to update the local list
      } else {
        print("Note with ID $id not found.");
      }
    } catch (e) {
      print("Error updating note: $e");
    }
    await fetchNotes();
  }

  // Delete a note
  Future<void> deleteNote(String id) async {
    await _noteRepository.deleteNote(id);
    await fetchNotes(); // Re-fetch notes
  }
}
