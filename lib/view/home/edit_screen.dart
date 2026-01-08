import 'package:flutter/material.dart';
import 'package:map_exam/data/model/notes.dart';
import 'package:map_exam/viewmodel/note_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:map_exam/components/ui/appbar.dart';

class EditScreen extends StatefulWidget {
  final String mode;
  final Note? note; // Note can be null in the case of 'Add New Note'

  EditScreen({Key? key, required this.mode, this.note}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing note data for editing or empty for new note
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final notesViewModel = Provider.of<NotesViewModel>(context, listen: false);

    if (widget.mode == 'edit') {
      notesViewModel.updateNote(
        widget.note!.id,
        _titleController.text,
        _contentController.text,
      );
    } else if (widget.mode == 'add') {
      notesViewModel.addNote(
        _titleController.text,
        _contentController.text,
      );
    }

    Navigator.pop(context); // Close the screen after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        mode: widget.mode, // Pass the mode ('edit', 'view', 'add')
        onSave: widget.mode != 'view' ? _saveNote : null,
        onClose: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter the note title',
                filled: widget.mode == 'view',
                fillColor: widget.mode == 'view' ? Colors.transparent : null,
              ),
              readOnly:
                  widget.mode == 'view', // Make it read-only in 'view' mode
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                hintText: 'Enter your note content here',
                filled: widget.mode == 'view',
                fillColor: widget.mode == 'view' ? Colors.transparent : null,
              ),
              readOnly:
                  widget.mode == 'view', // Make it read-only in 'view' mode
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
