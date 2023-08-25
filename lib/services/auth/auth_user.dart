import 'package:firebase_auth/firebase_auth.dart' show User;

/// Represents a user authenticated in the application.
class AuthUser {
  final String id; // Unique identifier for the user.
  final String email; // Email address of the user.
  final bool isEmailVerified; // Indicates whether the user's email is verified.
  final String? firstName; // First name of the user (if available).
  final String? lastName; // Last name of the user (if available).

  /// Constructs an instance of [AuthUser].
  ///
  /// [id] is the unique identifier for the user.
  /// [email] is the email address associated with the user.
  /// [isEmailVerified] indicates whether the user's email is verified.
  /// [firstName] is the first name of the user (if available).
  /// [lastName] is the last name of the user (if available).
  const AuthUser({
    required this.id,
    required this.email,
    required this.isEmailVerified,
    this.firstName,
    this.lastName,
  });

  /// Factory constructor to create an instance of [AuthUser] from a Firebase [user].
  ///
  /// Returns an [AuthUser] instance based on the information provided by the Firebase [user].
  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        isEmailVerified: user.emailVerified,
        email: user.email!,
        firstName: user.displayName,
        lastName: user.displayName,
      );
// Takes a Firebase user and creates an instance of our AuthUser class based on it.
// This allows us to create our own user representation without exposing Firebase internals.
}
