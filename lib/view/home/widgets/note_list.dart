import 'package:flutter/material.dart';
import 'package:map_exam/viewmodel/note_viewmodel.dart';
import 'package:provider/provider.dart';

class NoteListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesViewModel = Provider.of<NotesViewModel>(context);

    if (notesViewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        notesViewModel.notes.isEmpty
            ? Center(child: Text("No notes available."))
            : ListView.builder(
                itemCount: notesViewModel.notes.length,
                itemBuilder: (context, index) {
                  final note = notesViewModel.notes[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          note.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          note.content,
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                print("Edit note: ${note.title}");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                print("Delete note: ${note.title}");
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          print("Tapped on ${note.title}");
                        },
                      ),
                    ),
                  );
                },
              ),

        // Floating Action Buttons
        Positioned(
          bottom: 20,
          right: 20,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // "Show Less" button
              FloatingActionButton(
                onPressed: () {
                  // Logic for "Add New"
                  print("Add New pressed");
                },
                mini: true,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                tooltip: 'Add New Note',
                child: Icon(
                  Icons.expand_outlined,
                  color: Colors.white,
                  size: 16,
                ),
              ),

              FloatingActionButton(
                onPressed: () {
                  print("Collapse pressed");
                },
                mini: true,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                tooltip: 'Add New Note',
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
