import 'package:blog_app/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/user_login.dart';
import '../../domain/use_cases/user_sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp.call(
      UserSignUpParams(
        name: event.userSignUpParams.name,
        email: event.userSignUpParams.email,
        password: event.userSignUpParams.password,
      ),
    );
    response.fold(
      (left) => emit(AuthFailure(left.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin.call(
      UserLoginParams(
          email: event.userLoginParams.email,
          password: event.userLoginParams.password),
    );

    response.fold(
      (left) => emit(AuthFailure(left.message)),
      (right) => emit(
        AuthSuccess(right),
      ),
    );
  }
}
