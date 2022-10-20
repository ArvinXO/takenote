import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/components/fade_animation.dart';
import 'package:takenote/constants/k_constants.dart';
import 'package:takenote/constants/routes.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/services/cloud/firebase_cloud_storage.dart';
import 'package:takenote/utilities/dialogs/logout_dialog.dart';
import 'package:takenote/views/notes/folder_grid.dart';
import 'package:takenote/views/notes/notes_grid_view.dart';
import 'package:takenote/views/notes/notes_list_view.dart';

import '../../enums/menu_action.dart';

enum ViewType { tile, grid }

class FolderView extends StatefulWidget {
  const FolderView({Key? key}) : super(key: key);

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: NotesAppBarContainer,
          title: const Text(
            'Folders',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            PopupMenuButton<MenuAction>(
              // rounded corners
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              elevation: 10,
              offset: const Offset(0, 50),
              color: kJungleGreen,

              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      if (!mounted) {
                        return;
                      }
                      context.read<AuthBloc>().add(
                            const AuthEventLogOut(),
                          );
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Logging out',
                          textAlign: TextAlign.center,
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red.withOpacity(0.8),
                      ),
                    );
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: textLogoutStyle,
                  ),
                ];
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: _notesService.allNotes(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allNotes = snapshot.data as Iterable<CloudNote>;
                  return FolderGridView(
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
