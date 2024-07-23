import '../../../../core/common/cubits/app_user_cubit/app_user_cubit.dart';
import '../../../../core/common/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/current_user.dart';
import '../../domain/use_cases/user_login.dart';
import '../../domain/use_cases/user_sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp.call(
      UserSignUpParams(
        name: event.userSignUpParams.name,
        email: event.userSignUpParams.email,
        password: event.userSignUpParams.password,
      ),
    );
    response.fold(
      (left) => emit(AuthFailure(left.message)),
      (right) => _emitAuthSuccess(right, emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await _userLogin.call(
      UserLoginParams(
          email: event.userLoginParams.email,
          password: event.userLoginParams.password),
    );

    response.fold(
      (left) => emit(AuthFailure(left.message)),
      (right) => _emitAuthSuccess(right, emit),
    );
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response = await _currentUser.call(NoParams());
    response.fold(
      (left) => emit(AuthFailure(left.message)),
      (right) => _emitAuthSuccess(right, emit),
    );
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
