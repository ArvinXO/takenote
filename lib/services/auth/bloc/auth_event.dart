import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventUninitialized extends AuthEvent {
  const AuthEventUninitialized();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogIn(
    this.email,
    this.password,
  );
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  const AuthEventRegister(
    this.email,
    this.password,
  );
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventForgotPassword extends AuthEvent {
  final String? email;

  const AuthEventForgotPassword({
    this.email,
  });
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
