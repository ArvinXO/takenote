import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait...',
  });
}

// Represents the state when authentication is being initialized
class AuthStateInitialize extends AuthState {
  const AuthStateInitialize() : super(isLoading: true);
}

// Represents the uninitialized authentication state
class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

// Represents the state when authentication initialization is in progress
class AuthStateInitializing extends AuthState {
  final AuthUser user;
  const AuthStateInitializing({
    required bool isLoading,
    required this.user,
  }) : super(isLoading: isLoading);
}

// Represents the state when user registration is in progress
class AuthStateRegistering extends AuthState {
  final Exception? exception;

  const AuthStateRegistering({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

// Represents the state when password recovery is in progress
class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;
  const AuthStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

// Represents the state when a user is successfully logged in
class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({
    required bool isLoading,
    required this.user,
  }) : super(isLoading: isLoading);
}

// Represents the state when email verification is needed
class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required bool isLoading})
      : super(isLoading: isLoading);
}

// Represents the state when a user is logged out
class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;

  @override
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(isLoading: isLoading, loadingText: loadingText);

  @override
  List<Object?> get props => [exception, isLoading];
}
