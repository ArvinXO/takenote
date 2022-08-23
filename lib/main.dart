import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/helpers/loading/splash_screen.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';
import 'package:takenote/services/auth/firebase_auth_provider.dart';
import 'package:takenote/views/forgot_password_view.dart';
import 'package:takenote/views/homepage.dart';
import 'package:takenote/views/login_view.dart';
import 'package:takenote/views/notes/create_update_note_view.dart';
import 'package:takenote/views/register_view.dart';
import 'package:takenote/views/verify_email_view.dart';
import 'constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Take Note',
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStateUninitialized) {
              return const AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                switchOutCurve: Curves.easeInOut,
                child: SplashScreen(),
              );
            }
            if (state is AuthStateLoggedIn) {
              return const HomePage();
            } else if (state is AuthStateNeedsVerification) {
              return const VerifiyEmailView();
            } else if (state is AuthStateLoggedOut) {
              return const LoginView();
            } else if (state is AuthStateForgotPassword) {
              return const ForgotPasswordView();
            } else if (state is AuthStateRegistering) {
              return const RegisterView();
            } else {
              return const Scaffold(
                body: CircularProgressIndicator(),
              );
            }
          },
        ),
        routes: {
          //
          // Routes for the app
          createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
        },
      ),
    ),
  );
}
 
// TODO FlutterSlidable - NOTES LISTVIEW
