import 'package:flutter/material.dart';
import 'package:takenote/constants/routes.dart';
import 'package:takenote/views/login_views.dart';
import 'package:takenote/views/notes/new_note_view.dart';
import 'package:takenote/views/register_view.dart';
import 'package:takenote/views/verify_email_view.dart';

import 'views/homepage.dart';
import 'views/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Take Note',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        //
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifiyEmailView(),
        newNoteRoute: (context) => const NewNoteView(),
      },
    ),
  );
}
