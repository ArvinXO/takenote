import 'package:flutter/material.dart';
import 'package:takenote/constants/routes.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/services/cloud/firebase_cloud_storage.dart';
import 'package:takenote/views/notes/deleted_notes_grid_view.dart';
import 'package:takenote/views/notes/deleted_notes_list_view.dart';

enum ViewType { tile, grid }

class DeleteView extends StatefulWidget {
  const DeleteView({Key? key, required this.isGridView}) : super(key: key);
  final bool isGridView; // Add this line

  @override
  State<DeleteView> createState() => _DeleteViewState();
}

class _DeleteViewState extends State<DeleteView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    // _notesService.open();
    //Ensure DB OPEN NEGATES THE EXTRA CALL
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
        // stream archived notes
        stream: _notesService.deletedNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData && widget.isGridView) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return DeletedNotesGridView(
                  notes: allNotes,
                  onDeleteNote: (note) async {
                    await _notesService.deleteNote(documentId: note.documentId);
                    //
                  },
                  onNoteTap: (CloudNote note) {
                    Navigator.of(context).pushNamed(
                      createOrUpdateNoteRoute,
                      arguments: note,
                    );
                  },
                  notesService: _notesService,
                );
              } else if (snapshot.hasData && !widget.isGridView) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return DeletedNotesListView(
                  notes: allNotes,
                  onDeleteNote: (note) async {
                    await _notesService.deleteNote(documentId: note.documentId);
                  },
                  onNoteTap: (CloudNote note) {
                    Navigator.of(context).pushNamed(
                      createOrUpdateNoteRoute,
                      arguments: note,
                    );
                  },
                  notesService: _notesService,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
