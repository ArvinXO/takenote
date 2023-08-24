import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser {
  final String id;
  final String email;
  final bool isEmailVerified;
  final String? firstName;
  final String? lastName;
  const AuthUser({
    required this.id,
    required this.email,
    required this.isEmailVerified,
    this.firstName,
    this.lastName,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        isEmailVerified: user.emailVerified,
        email: user.email!,
        firstName: user.displayName,
        lastName: user.displayName,
      );
  // Take firebase user + create instance of our own class given that user.
  //Takes Firebase user and makes a copy. Not exposing Firebase UI
}
