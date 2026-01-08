import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_exam/components/ui/appbar.dart';
import 'package:map_exam/routes/routes.dart';
import 'package:map_exam/view/home/widgets/note_list.dart';
import 'package:map_exam/viewmodel/login_viewmodel.dart';
import 'package:map_exam/viewmodel/note_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchNotes();

    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _fetchNotes();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchNotes() async {
    await Provider.of<NotesViewModel>(context, listen: false).fetchNotes();
  }

  Future<void> _refreshNotes() async {
    await _fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notesViewModel = Provider.of<NotesViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(
        mode: 'home',
        totalNotes:
            notesViewModel.notes.length, // Dynamically pass the total notes
        onLogout: () {
          loginViewModel.signout(context);
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNotes, // Pull-to-refresh functionality
        child: NoteListWidget(), // Your list widget displaying notes
      ),
    );
  }
}
