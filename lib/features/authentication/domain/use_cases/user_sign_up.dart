import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usercase.dart';
import '../../../../core/common/entities/user_entity.dart';
import 'package:blog_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<UserEntity, UserSignUpParams> {
  final AuthRepository authRepository;

  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(
      UserSignUpParams userSignUpParams) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: userSignUpParams.email,
      name: userSignUpParams.name,
      password: userSignUpParams.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
