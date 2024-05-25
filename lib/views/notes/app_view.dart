import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:takenote/constants/k_constants.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/views/archived_view.dart';
import 'package:takenote/views/delete_view.dart';
import 'package:takenote/views/notes_view.dart';

import '../../constants/routes.dart';
import '../../enums/menu_action.dart';
import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';
import '../../utilities/dialogs/logout_dialog.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  // Get the current user's ID
  String get userId => AuthService.firebase().currentUser!.id;
  late PageController _pageController;
  int _page = 0;
  final ValueNotifier<String> _appBarTitle = ValueNotifier<String>('');
  late bool isGridView; // Define isGridView here

  @override
  void initState() {
    _pageController = PageController();
    isGridView = false; // Initialize isGridView
    super.initState();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
      _updateAppBarTitle(page); // Add this line to update the app bar title
    });
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _updateAppBarTitle(int pageIndex) {
    switch (pageIndex) {
      case 0:
        _appBarTitle.value = 'Notes';
        break;
      case 1:
        _appBarTitle.value = 'Archived Notes';
        break;
      case 2:
        _appBarTitle.value = 'Deleted Notes';
        break;
    }

    // Add the setState() call to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // List of views for the PageView
    final _pageList = <Widget>[
      NotesView(isGridView: isGridView), // Pass the isGridView variable
      ArchivedView(isGridView: isGridView),
      DeleteView(isGridView: isGridView),
    ];

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: NotesAppBarContainer,
        backgroundColor: kBdazalledBlue.withOpacity(0.95),
        title: ValueListenableBuilder<String>(
          valueListenable: _appBarTitle,
          builder: (context, title, _) => Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'Poppins',
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
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
                    backgroundColor: kJungleGreen.withOpacity(0.3),
                  ),
                );
              });
            },
            //icon is grid or list
            icon: isGridView
                ? const Icon(
                    Icons.list,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.view_module_rounded,
                    color: Colors.white,
                  ),
          ),
          PopupMenuButton<MenuAction>(
            // rounded corners
            iconColor: Colors.white,
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
      // Set the floating action button location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: kBdazalledBlue.withOpacity(0.95),
      body: Container(
        // Apply gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              kJungleGreen.withOpacity(0.9),
              kOxfordBlue,
              kOxfordBlue,
              kOxfordBlue,
              kOxfordBlue,
              kOxfordBlue,
              kOxfordBlue,
              kOxfordBlue,
            ],
          ),
        ),
        child: PageView(
          scrollDirection: Axis.vertical,
          physics: const RangeMaintainingScrollPhysics(),
          onPageChanged: onPageChanged,
          controller: _pageController,
          children: _pageList,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: kOxfordBlue.withOpacity(0.9),
        selectedItemColor: kJungleGreen,
        iconSize: 30,
        unselectedItemColor: Colors.grey,
        elevation: 55,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.note),
            activeIcon: Icon(Iconsax.note1),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.archive),
            activeIcon: Icon(Iconsax.archive_11),
            label: 'Archive',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.trash),
            activeIcon: Icon(Iconsax.trash4),
            label: 'Deleted',
          ),
        ],
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: navigationTapped,
      ),
      // Build the appropriate floating action button based on the current page
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // Build the floating action button based on the current page
  Widget _buildFloatingActionButton() {
    if (_page == 0) {
      return FloatingActionButton(
        tooltip: 'Add Note',
        backgroundColor: kJungleDarkGreen.withOpacity(0.6),
        hoverColor: kBdazalledBlue,
        splashColor: kBdazalledBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        elevation: 10,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        onPressed: () {
          Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
        },
        child: const Icon(Iconsax.add_circle, size: 30),
      );
    } else if (_page == 1) {
      return FloatingActionButton(
        tooltip: 'Add Archive Note',
        backgroundColor: kJungleDarkGreen.withOpacity(0.6),
        hoverColor: kBdazalledBlue,
        splashColor: kBdazalledBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        elevation: 10,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        onPressed: () {
          Navigator.of(context).pushNamed(createOrUpdateArchiveNoteRoute);
        },
        child: const Icon(Iconsax.archive_add4, size: 30),
      );
    } else {
      // Return a default widget here
      return const SizedBox();
    }
  }
}
