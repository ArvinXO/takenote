import 'package:takenote/services/auth/firebase_auth_provider.dart';

import 'auth_provider.dart';
import 'auth_user.dart';

/// A service class that acts as a bridge between the app and the authentication provider.
///
/// This class implements the [AuthProvider] interface and provides a high-level
/// API for handling authentication-related operations.
class AuthService implements AuthProvider {
  final AuthProvider provider;

  /// Constructs an instance of [AuthService] with a specific [provider].
  ///
  /// The [provider] parameter should be an implementation of [AuthProvider]
  /// that handles the actual authentication operations.
  const AuthService(this.provider);

  /// Factory constructor to create an instance of [AuthService] with Firebase authentication.
  ///
  /// Returns an [AuthService] instance that uses the [FirebaseAuthProvider]
  /// as the underlying authentication provider.
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
  }) =>
      provider.createUser(
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> sendPasswordResetEmail({required String toEmail}) =>
      provider.sendPasswordResetEmail(toEmail: toEmail);
}
