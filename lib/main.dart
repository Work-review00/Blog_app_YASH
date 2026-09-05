import 'package:blog_app/core/secrets/app_secret.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/feature/auth/presentaion/bloc/auth_bloc.dart';
import 'package:blog_app/feature/auth/presentaion/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    // ignore: deprecated_member_use
    anonKey: AppSecret.supabaseAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: UserSignUp(
              AuthRepositoryImpl(AuthRemoteDataSourceImpl(supabase.client)),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,

      home: const LoginPage(),
    );
  }
}
