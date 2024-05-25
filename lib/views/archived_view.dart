import 'package:flutter/material.dart';
import 'package:takenote/constants/routes.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/services/cloud/firebase_cloud_storage.dart';
import 'package:takenote/views/notes/archived_notes_grid_view.dart';
import 'package:takenote/views/notes/archived_notes_list_view.dart';
import 'package:takenote/widgets/animations/fade_animation.dart';

enum ViewType { tile, grid }

class ArchivedView extends StatefulWidget {
  final bool isGridView; // Add this line

  const ArchivedView({Key? key, required this.isGridView}) : super(key: key);

  @override
  State<ArchivedView> createState() => _ArchivedViewState();
}

class _ArchivedViewState extends State<ArchivedView> {
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
    return FadeAnimation(
      delay: 0.2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          // stream archived notes
          stream: _notesService.archivedNotes(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData && widget.isGridView) {
                  final allNotes = snapshot.data as Iterable<CloudNote>;
                  return ArchivedNotesGridView(
                    notes: allNotes,
                    onDeleteNote: (note) async {
                      await _notesService.deleteNote(
                          documentId: note.documentId);
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
                  return ArchivedNotesListView(
                    notes: allNotes,
                    onDeleteNote: (note) async {
                      await _notesService.deleteNote(
                          documentId: note.documentId);
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
      ),
    );
  }
}
