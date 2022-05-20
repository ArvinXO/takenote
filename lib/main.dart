import 'package:flutter/material.dart';
import 'package:takenote/views/login_views.dart';
import 'package:takenote/views/register_view.dart';
import 'package:takenote/views/verify_email_view.dart';

import 'enums/menu_action.dart';
import 'firebase_options.dart';
import 'services/auth/auth_service.dart';
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
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/notes/': (context) => const NotesView(),
        '/verify-email/': (context) => const VerifiyEmailView(),
      },
    ),
  );
}
//

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
              } else {
                return const VerifiyEmailView();
              }
            } else {
              return const LoginView();
            }
            // if (user?.emailVerified ?? false) {
            // } else {
            //   print(user);
            //   return const VerifiyEmailView();
            // }
            // return const Text('Done.....');
            return const NotesView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
