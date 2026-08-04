import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'core/app_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppState.isDarkMode,
      builder: (context, isDark, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: AppState.isVietnamese,
          builder: (context, isVi, _) {
            return MaterialApp(
              key: ValueKey(isVi),
              debugShowCheckedModeBanner: false,
              title: 'Vocab App',
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              theme: ThemeData.light().copyWith(
                primaryColor: const Color(0xFF2575FC),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF6A11CB),
                  foregroundColor: Colors.white,
                ),
              ),
              darkTheme: ThemeData.dark().copyWith(
                primaryColor: const Color(0xFF2575FC),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF1E1E1E),
                  foregroundColor: Colors.white,
                ),
              ),
              home: const LoginScreen(),
            );
          },
        );
      },
    );
  }
}
