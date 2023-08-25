import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

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
  }

  /// Creates a new user with the provided [email], [password], [firstname], and [lastname].
  ///
  /// Returns the created [AuthUser] instance if successful, otherwise throws appropriate exceptions.
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
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
      switch (e.code) {
        case 'user-not-found':
        case 'email-already-in-use':
        case 'weak-password':
        case 'invalid-email':
          throw AuthExceptionMapper.mapException(e);
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  /// Gets the currently logged-in [AuthUser], if available.
  ///
  /// Returns the [AuthUser] instance of the current user, or `null` if not logged in.
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  /// Logs in the user using the provided [email] and [password].
  ///
  /// Returns the logged-in [AuthUser] instance if successful, otherwise throws appropriate exceptions.
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
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
          throw AuthExceptionMapper.mapException(e);
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  /// Logs out the currently logged-in user.
  ///
  /// Signs out the user if logged in, otherwise throws [UserNotLoggedInAuthException].
  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  /// Sends an email verification to the current user's email.
  ///
  /// Throws [UserNotVerifiedAuthException] if the user is already verified, or
  /// [TooManyVerificationEmailRequests] if there are too many requests to send verification emails.
  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified == false) {
      try {
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'firebase_auth/too-many-requests') {
          throw TooManyVerificationEmailRequests();
        }
      }
    } else {
      throw UserNotVerifiedAuthException();
    }
  }

  /// Sends a password reset email to the provided [toEmail].
  ///
  /// Throws appropriate exceptions based on the error codes returned by Firebase.
  @override
  Future<void> sendPasswordResetEmail({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: toEmail,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionMapper.mapException(e);
    } catch (_) {
      throw GenericAuthException();
    }
  }
}

/// Maps Firebase authentication exceptions to custom exceptions.
class AuthExceptionMapper {
  static Exception mapException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return UserNotFoundAuthException();
      case 'email-already-in-use':
        return EmailAlreadyInUseAuthException();
      case 'weak-password':
        return WeakPasswordAuthException();
      case 'invalid-email':
        return InvalidEmailAuthException();
      default:
        return GenericAuthException();
    }
  }
}
