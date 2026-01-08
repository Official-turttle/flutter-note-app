import 'package:flutter/material.dart';
import 'package:map_exam/routes/routes.dart';
import 'package:map_exam/viewmodel/note_viewmodel.dart';
import 'package:provider/provider.dart';

class NoteListWidget extends StatefulWidget {
  @override
  _NoteListWidgetState createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteListWidget> {
  bool isContentVisible = true; // Track if content is visible or not
  int?
      _selectedNoteIndex; // Store the index of the selected note for editing tools

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
                        title: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              if (_selectedNoteIndex == index) {
                                _selectedNoteIndex = null;
                              } else {
                                _selectedNoteIndex = index;
                              }
                            });
                          },
                          child: Text(
                            note.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  16, // Adjusted to keep a consistent font size for the title
                            ),
                          ),
                        ),
                        subtitle: isContentVisible
                            ? Text(
                                note.content,
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    3, // Limiting to 3 lines when content is visible
                              )
                            : null, // Hide content when collapsed
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_selectedNoteIndex == index)
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.edit,
                                    arguments: {
                                      'mode': 'edit',
                                      'note': note,
                                    }, // Pass mode and note
                                  );
                                },
                              ),
                            if (_selectedNoteIndex == index)
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  notesViewModel.deleteNote(note.id);
                                },
                              ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.edit,
                            arguments: {
                              'mode': 'view',
                              'note': note,
                            }, // Pass mode and note
                          );
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
              // Show Less button
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isContentVisible =
                        !isContentVisible; // Toggle visibility of content only
                  });
                },
                mini: true,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                tooltip: isContentVisible ? 'Show Less' : 'Show More',
                child: Icon(
                  isContentVisible ? Icons.arrow_drop_up_rounded : Icons.menu,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              // Add New button
              FloatingActionButton(
                onPressed: () {
                  // Logic for "Add New"
                  Navigator.pushNamed(
                    context,
                    AppRoutes.edit,
                    arguments: {
                      'mode': 'add',
                      'note': null
                    }, // Pass mode and null for a new note
                  );
                },
                mini: true,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                tooltip: "Add new",
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
