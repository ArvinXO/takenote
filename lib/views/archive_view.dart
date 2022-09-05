import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:takenote/constants/k_constants.dart';
import 'package:takenote/constants/routes.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';

import '../enums/menu_action.dart';
import '../services/auth/bloc/auth_event.dart';
import '../utilities/dialogs/logout_dialog.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  final TextEditingController _searchController = TextEditingController();
  bool isGridView = false;
  bool isTileView = true;
  int selectedPageColor = 1;

  loadArchiveNotes() async {
    setState(() {});
  }

  @override
  void initState() {
    loadArchiveNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBdazalledBlue,
        appBar: AppBar(
          backgroundColor: kOxfordBlue,
          title: const Text('Archive'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
              },
              icon: const Icon(Icons.add),
            ),
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
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //if notes view is available show else show container

                Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        height: 150,
                      ),
                      Icon(
                        Iconsax.archive_minus,
                        size: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'empty!',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 22),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
