import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_exam/data/model/notes.dart';

class NoteRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Fetching all notes
  Future<List<Note>> getNotes() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot data = await _firebaseFirestore
          .collection('notes')
          .where('userId', isEqualTo: userId)
          .get();

      List<Note> notes = data.docs.map((doc) {
        return Note.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      print("Fetched Notes: ");
      for (var note in notes) {
        note.printNote(); // This will print each note's details
      }
      return notes;
    } catch (e) {
      print("Error fetching notes: $e");
      return [];
    }
  }

  // Adding a new note
  Future<void> addNote(Note note) async {
    try {
      await _firebaseFirestore.collection('notes').add({
        'title': note.title,
        'content': note.content,
        'userId': note.userId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding note: $e");
    }
  }

  // Updating a note
  Future<void> updateNote(String id, Note note) async {
    try {
      await _firebaseFirestore.collection('notes').doc(id).update({
        'title': note.title,
        'content': note.content,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("Note updated with ID: $id");
    } catch (e) {
      print("Error updating note: $e");
    }
  }

  // Deleting a note
  Future<void> deleteNote(String id) async {
    try {
      // print("deleting id ${id}");
      await _firebaseFirestore.collection('notes').doc(id).delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }
}
