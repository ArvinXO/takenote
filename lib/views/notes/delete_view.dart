import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/constants/k_constants.dart';
import 'package:takenote/constants/routes.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/services/cloud/firebase_cloud_storage.dart';
import 'package:takenote/utilities/dialogs/logout_dialog.dart';
import 'package:takenote/views/notes/deleted_notes_grid_view.dart';
import 'package:takenote/views/notes/deleted_notes_list_view.dart';

import '../../enums/menu_action.dart';

enum ViewType { tile, grid }

class DeleteView extends StatefulWidget {
  const DeleteView({Key? key}) : super(key: key);

  @override
  State<DeleteView> createState() => _DeleteViewState();
}

class _DeleteViewState extends State<DeleteView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;
  bool isGridView = false;
  bool isTileView = true;

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                kOxfordBlue.withOpacity(0.9),
                kJungleGreen.withOpacity(0.3),
              ],
            ),
          ),
        ),
        title: const Text(
          'Deleted Notes',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
          //   },
          //   icon: const Icon(Icons.add),
          // ),
          //PopupMenuButton grid or list

          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            //icon is grid or list
            icon: isGridView
                ? const Icon(Icons.list)
                : const Icon(Icons.view_module_rounded),
          ),
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
        // stream archived notes
        stream: _notesService.deletedNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData && isGridView) {
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
              } else if (snapshot.hasData && !isGridView) {
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
