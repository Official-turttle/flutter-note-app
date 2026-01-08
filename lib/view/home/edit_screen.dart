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

  @override
  Widget build(BuildContext context) {
    final notesViewModel = Provider.of<NotesViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(
        mode: widget.mode, // Pass the mode ('edit', 'view', 'add')
        onSave: () {
          if (widget.mode == 'edit') {
            notesViewModel.updateNote(
              widget.note!.id,
              _titleController.text,
              _contentController.text,
            );
          } else {
            notesViewModel.addNote(
                _titleController.text, _contentController.text);
          }
          Navigator.pop(context);
        },
        onClose: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
