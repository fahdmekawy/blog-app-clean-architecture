part of 'app_user_cubit.dart';

sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final UserEntity user;

  const AppUserLoggedIn(this.user);
}
