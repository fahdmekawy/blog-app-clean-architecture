import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/imports.dart';
import 'features/blog/presentation/screens/blog_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<BlogBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
