import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import 'login_views.dart';
import 'notes_view.dart';
import 'verify_email_view.dart';

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
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
