import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:takenote/constants/k_constants.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/views/archive_view.dart';
import 'package:takenote/views/notes_view.dart';

import '../../constants/routes.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  String get userId => AuthService.firebase().currentUser!.id;
  bool isGridView = false;
  late PageController _pageController;
  int _page = 0;
  final _pageList = <Widget>[
    const NotesView(),
    const ArchivePage(),
  ];
  @override
  void initState() {
    // _notesService.open();
    //Ensure DB OPEN NEGATES THE EXTRA CALL
    _pageController = PageController();
    super.initState();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: kBdazalledBlue,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        controller: _pageController,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.archive),
            label: 'Archive',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.search_normal),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: navigationTapped,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Note',
        //centered
        backgroundColor: kJungleGreen,
        hoverColor: kBdazalledBlue,
        splashColor: kBdazalledBlue,
        shape: // square
            const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        elevation: 10,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,

        onPressed: () {
          setState(() {
            Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
          });
        },
        child: const Icon(Iconsax.add, size: 30),
      ),
    );
  }
}
