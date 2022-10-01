import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';
import 'auth_user.dart';
import 'auth_provider.dart';
import 'auth_exceptions.dart';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    kDebugMode ? print('Firebase initialized') : null;
  }

  // Check for authstate changes  and return the user if there is one or null if there is not one


  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  // If there is a user, return a firebase user otherwise null
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified == false) {
      try {
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'firebase_auth/too-many-requests':
            throw TooManyVerificationEmailRequests();
        }
      }
    } else {
      throw UserNotVerifiedAuthException();
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: toEmail,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase-auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase-auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }
}

// User not verified and too many requests to send verification email
  // @override
  // Future<void> sendEmailVerification() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null && user.emailVerified == false) {
  //     try {
  //       await user.sendEmailVerification();
  //     } on FirebaseAuthException catch (e) {
  //       switch (e.code) {
  //         case 'firebase_auth/too-many-requests':
  //           throw TooManyVerificationEmailRequests();
  //       }
  //     }
  //   } else {
  //     throw UserNotVerifiedAuthException();
  //   }
  // }
