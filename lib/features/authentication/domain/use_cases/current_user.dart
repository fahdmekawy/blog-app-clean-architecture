import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usercase.dart';
import '../../../../core/common/entities/user_entity.dart';
import 'package:blog_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}

class NoParams {}
