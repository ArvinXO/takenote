// Exception thrown when the user is not found during login
class UserNotFoundAuthException implements Exception {}

// Exception thrown when the password provided during login is incorrect
class WrongPasswordAuthException implements Exception {}

// Exception thrown when the user has not verified their email address
class UserNotVerifiedAuthException implements Exception {}

// Exception thrown when the provided password is too weak during registration
class WeakPasswordAuthException implements Exception {}

// Exception thrown when the provided email is already associated with an account during registration
class EmailAlreadyInUseAuthException implements Exception {}

// Exception thrown when the provided email is invalid during registration
class InvalidEmailAuthException implements Exception {}

// Generic exception for authentication-related errors
class GenericAuthException implements Exception {}

// Exception thrown when an action requires the user to be logged in but they are not
class UserNotLoggedInAuthException implements Exception {}

// Exception thrown when there have been too many requests for email verification
class TooManyVerificationEmailRequests implements Exception {}
