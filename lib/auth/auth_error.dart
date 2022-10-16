//

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/foundation.dart' show immutable;

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;
  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
       AuthErrorUnknown(exception);
}

@immutable
class AuthErrorUnknown extends AuthError {
  final FirebaseAuthException innerException;
  const AuthErrorUnknown(this.innerException)
      : super(
          dialogTitle: 'Authentication Error',
          dialogText: 'Unknown authentication error',
        );
}

// auth/user-not-found
@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          dialogText: 'No current user!',
          dialogTitle: 'No current user with this information was found!',
        );
}

@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          dialogText: 'Requires recent login !',
          dialogTitle:
              'You need to log out and log back in again in order to perform this operation',
        );
}

// email password sign in not enabled, remember to enable it before running it

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          dialogText: 'Operation not allowed !',
          dialogTitle: 'You can not register using method at this moment !',
        );
}

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          dialogText: 'User not found !',
          dialogTitle: 'The given user was not found on the server !',
        );
}

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          dialogText: 'Weak password !',
          dialogTitle:
              'Please choose a stronger consisting of more characters!',
        );
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          dialogText: 'Invalid Email !',
          dialogTitle: 'Please double check your email and try again !',
        );
}

@immutable
class AuthErrorAlreadyInUse extends AuthError {
  const AuthErrorAlreadyInUse()
      : super(
          dialogText: 'Email already in use !',
          dialogTitle: 'Please choose another email to register with !',
        );
}


