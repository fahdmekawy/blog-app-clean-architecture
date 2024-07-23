import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/authentication/data/data_sources/auth_remote_data_source.dart';
import '../../../../core/common/entities/user_entity.dart';
import 'package:blog_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImplementation(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
      Future<UserEntity> Function() callback) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await callback();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged in'));
        }
        return right(UserEntity(
            id: session.user.id, name: '', email: session.user.email ?? ''));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not found'));
      }
      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
