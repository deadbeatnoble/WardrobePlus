import 'package:WardrobePlus/core/di/injection_container.dart';
import 'package:WardrobePlus/core/themes/app_theme.dart';
import 'package:WardrobePlus/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:WardrobePlus/features/auth/presentation/pages/getting_started.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/pages/wardrobe_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeMode,
        home: WardrobePage(),
      ),
    );
  }
}
