part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final UserSignUpParams userSignUpParams;

  AuthSignUp({required this.userSignUpParams});
}

final class AuthLogin extends AuthEvent {
  final UserLoginParams userLoginParams;

  AuthLogin({required this.userLoginParams});
}

final class AuthIsUserLoggedIn extends AuthEvent {}
