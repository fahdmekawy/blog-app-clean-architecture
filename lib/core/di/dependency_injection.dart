import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:blog_app/features/authentication/domain/use_cases/current_user.dart';
import 'package:blog_app/features/authentication/domain/use_cases/user_login.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/authentication/data/repositories/auth_repository_implementaion.dart';
import '../../features/authentication/domain/use_cases/user_sign_up.dart';
import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../secrets/app_secrets.dart';

// initialize the service locator
final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Auth Services
  _initAuth();
  // Initialize Supabase

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonToken,
  );

  // Register Supabase Client
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );
  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  // Data Source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImplementation(
        serviceLocator(),
      ),
    )
    // Use Cases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    ); // Register Auth Bloc
}
