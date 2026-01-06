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
    notifyListeners();
  }

  // Add a new note
  Future<void> addNote(String title, String content) async {
    final String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get the current user's UID
    await _noteRepository
        .addNote(Note(title: title, content: content, userId: userId));
    await fetchNotes();
  }

  // Update an existing note
  Future<void> updateNote(String id, Note note) async {
    await _noteRepository.updateNote(id, note);
    await fetchNotes();
  }

  // Delete a note
  Future<void> deleteNote(String id) async {
    await _noteRepository.deleteNote(id);
    await fetchNotes(); // Re-fetch notes
  }
}
