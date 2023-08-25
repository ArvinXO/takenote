import 'package:flutter/material.dart';

// Abstract base class for all authentication events
@immutable
abstract class AuthEvent {
  const AuthEvent();
}

// Represents the uninitialized authentication state
class AuthEventUninitialized extends AuthEvent {
  const AuthEventUninitialized();
}

// Represents the initialization of the authentication process
class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

// Represents the initialization of the authentication process in progress
class AuthEventInitializing extends AuthEvent {
  const AuthEventInitializing();
}

// Represents a user's attempt to log in
class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogIn(
    this.email,
    this.password,
  );
}

// Represents the event to send an email verification
class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

// Represents a user's registration process
class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  const AuthEventRegister(
    this.email,
    this.password,
    this.firstname,
    this.lastname,
  );
}

// Represents the event indicating that user registration is needed
class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

// Represents the event for password recovery
class AuthEventForgotPassword extends AuthEvent {
  final String? email;

  const AuthEventForgotPassword({
    this.email,
  });
}

// Represents a user's attempt to log out
class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
