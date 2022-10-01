import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/helpers/loading/splash_screen.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';
import 'package:takenote/services/auth/firebase_auth_provider.dart';
import 'package:takenote/views/forgot_password_view.dart';
import 'package:takenote/views/homepage.dart';
import 'package:takenote/views/login_view.dart';
import 'package:takenote/views/notes/create_update_archive_note_view.dart';
import 'package:takenote/views/notes/create_update_note_view.dart';
import 'package:takenote/views/notes/settings_view.dart';
import 'package:takenote/views/onboarding_view.dart';
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
        // Show splash screen while loading then show introduction
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if( state is AuthStateUninitialized && Platform.isLinux){
              if (BlocProvider.of<AuthBloc>(context).state is AuthStateUninitialized) {
                 kDebugMode ? print('AuthStateUninitialized') : null;
                BlocProvider.of<AuthBloc>(context).add(const AuthEventInitializing());
              } else {
                BlocProvider.of<AuthBloc>(context).add(const AuthEventInitialize());
                kDebugMode ? print('AuthEVent initialise') : null;

              }
            }
            if (state is AuthStateUninitialized && Platform.isAndroid || Platform.isIOS) {
              return const AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                switchOutCurve: Curves.easeInOut,
                child: //Platform is android show splash else show homepage directly
                    SplashScreen(),
              );
            }

            if (state is AuthStateLoggedIn) {
              //authstateinitializing = false
              // emit initialized
              return const HomePage();
            } else if (state is AuthStateNeedsVerification) {
              return const VerifiyEmailView();
            } else if (state is AuthStateLoggedOut) {
              kDebugMode ? print('AuthStateLoggedOut') : null;
              return const LoginView();
            } else if (state is AuthStateInitializing) {
              return const IntroductionPage();
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
          createOrUpdateArchiveNoteRoute: (context) =>
              const CreateUpdateArchiveNoteView(),
          settingsRoute: (context) => const SettingsView(),
        },
      ),
    ),
  );
}
 
// TODO FlutterSlidable - NOTES LISTVIEW
