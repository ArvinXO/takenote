import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/constants/k_constants.dart';
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
  bool isGridView = false;
  bool isTileView = true;
  int selectedPageColor = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBdazalledBlue,
      appBar: AppBar(
        backgroundColor: kOxfordBlue,
        title: const Text(
          'Archive',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
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
    );
  }
}
