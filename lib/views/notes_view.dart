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
import 'package:takenote/views/notes/notes_grid_view.dart';
import 'package:takenote/views/notes/notes_list_view.dart';

import '../enums/menu_action.dart';

enum ViewType { tile, grid }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;
  bool isGridView = true;
  bool isTileView = false;

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
      // drawer: SizedBox(
      //   width: MediaQuery.of(context).size.width * 0.5, //<-- SEE HERE

      //   child: Drawer(
      //     // Add a ListView to the drawer. This ensures the user can scroll
      //     // through the options in the drawer if there isn't enough vertical
      //     // space to fit everything.
      //     child: ListView(
      //       // Important: Remove any padding from the ListView.
      //       padding: EdgeInsets.zero,
      //       children: [
      //         const DrawerHeader(
      //           decoration: BoxDecoration(
      //             color: kJungleGreen,
      //           ),
      //           // logo
      //           child: FlutterLogo(),
      //         ),
      //         ListTile(
      //           leading: const Icon(Icons.home_filled),
      //           title: const Text('Home'),
      //           onTap: () {
      //             Navigator.pop(context);
      //             // Update the state of the app.
      //             // ...
      //           },
      //         ),
      //         ListTile(
      //           leading: const Icon(Icons.folder),
      //           title: const Text('Folders'),
      //           onTap: () {
      //             // Update the state of the app.
      //             // ...
      //           },
      //         ),
      //         ListTile(
      //           leading: const Icon(Icons.archive_rounded),
      //           title: const Text('Archive'),
      //           onTap: () {
      //             // Update the state of the app.
      //             // ...
      //           },
      //         ),
      //         ListTile(
      //           leading: //Bin setting
      //               const Icon(Icons.delete),
      //           title: const Text('Bin'),
      //           onTap: () {
      //             // Update the state of the app.
      //             // ...
      //           },
      //         ),
      //         ListTile(
      //           leading: //Icon setting
      //               const Icon(Icons.settings),
      //           title: const Text('Settings'),
      //           onTap: () {
      //             Navigator.of(context).push(//push to settings page
      //                 MaterialPageRoute(
      //                     builder: (context) => const SettingsView()));
      //             // Update the state of the app.
      //             // ...
      //           },
      //         ),
      //         const AboutListTile(
      //           // <-- SEE HERE
      //           icon: Icon(
      //             Icons.info,
      //           ),
      //           applicationIcon: Icon(
      //             Icons.local_play,
      //           ),
      //           applicationName: 'Take Note',
      //           applicationVersion: '1.0.25',
      //           applicationLegalese: '© 2022 Company',
      //           aboutBoxChildren: [
      //             ///Content goes here...
      //           ],
      //           child: Text('About app'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            // rounded corners
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                kJungleGreen.withOpacity(0.3),
                kOxfordBlue.withOpacity(0.9),
              ],
            ),
          ),
        ),
        title: const Text(
          'Notes',
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
                ? const Icon(Icons.view_module_rounded)
                : const Icon(Icons.list),
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
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData && isGridView) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return NotesGridView(
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
              } else if (snapshot.hasData && !isGridView) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return NotesListView(
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
