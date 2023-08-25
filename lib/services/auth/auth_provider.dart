import 'auth_user.dart';

/// An abstract class representing an authentication provider.
abstract class AuthProvider {
  /// Initializes the authentication provider.
  ///
  /// This method is responsible for any necessary setup, such as
  /// configuring authentication services or performing initializations.
  /// It should be called before any other methods are used.
  Future<void> initialize();

  /// Retrieves the currently authenticated user.
  ///
  /// If a user is currently authenticated, this method returns
  /// an instance of [AuthUser]. If no user is authenticated, it returns null.
  AuthUser? get currentUser;

  /// Authenticates a user using their email and password.
  ///
  /// Takes the user's email and password as parameters and returns
  /// a [Future] that resolves to the authenticated [AuthUser] instance.
  /// If authentication fails, an appropriate exception should be thrown.
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  /// Creates a new user account.
  ///
  /// Requires the user's email, password, first name, and last name.
  /// Returns a [Future] that resolves to the created [AuthUser] instance.
  /// If the account creation fails (e.g., due to weak password, email
  /// already in use), the appropriate exception should be thrown.
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
  });

  /// Logs out the currently authenticated user.
  ///
  /// This method signs out the user and clears any cached authentication data.
  Future<void> logOut();

  /// Sends an email verification to the authenticated user.
  ///
  /// If the user's email is not verified, this method sends an email
  /// containing a verification link to the user's registered email address.
  /// After successful verification, the user's email should be marked as verified.
  Future<void> sendEmailVerification();

  /// Sends a password reset email to the specified email address.
  ///
  /// If a user requests a password reset, this method sends an email
  /// containing instructions for resetting the password to the provided
  /// email address. The user can then follow the instructions to reset their password.
  Future<void> sendPasswordResetEmail({
    required String toEmail,
  });
}
