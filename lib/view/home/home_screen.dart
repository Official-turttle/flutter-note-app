import 'package:flutter/material.dart';
import 'package:map_exam/view/home/widgets/note_list.dart';
import 'package:map_exam/viewmodel/note_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:map_exam/components/ui/appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notes for the current user
    Provider.of<NotesViewModel>(context, listen: false).fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notesViewModel = Provider.of<NotesViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(
        totalNotes:
            notesViewModel.notes.length, // Dynamically pass the total notes
      ),
      body: NoteListWidget(),
    );
  }
}
