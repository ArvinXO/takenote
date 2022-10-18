import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/k_constants.dart';
import '../enums/menu_action.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';
import '../utilities/dialogs/logout_dialog.dart';

class ActionToolBar extends StatefulWidget {
  const ActionToolBar({super.key});

  @override
  State<ActionToolBar> createState() => _ActionToolBarState();
}

class _ActionToolBarState extends State<ActionToolBar> {
  bool isGridView = true;

  bool isTileView = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              //NotesGridView or NotesListView  is shown
              isGridView = !isGridView;
              //Show Snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: isGridView
                      ? const Text(
                          'Grid View',
                          textAlign: TextAlign.center,
                        )
                      : const Text(
                          'List View',
                          textAlign: TextAlign.center,
                        ),
                  duration: const Duration(seconds: 1),
                  backgroundColor: kJungleGreen.withOpacity(0.75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
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
    );
  }
}
