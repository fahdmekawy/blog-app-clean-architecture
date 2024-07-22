import 'package:blog_app/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/features/authentication/domain/repository/auth_repository.dart';
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
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // Register Auth Remote Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(serviceLocator()));
// Register Auth Repository
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImplementation(serviceLocator()));

  // Register Auth Use Cases
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  // Register Auth Bloc
  serviceLocator.registerLazySingleton<AuthBloc>(() =>
      AuthBloc(userSignUp: serviceLocator(), userLogin: serviceLocator()));
}
