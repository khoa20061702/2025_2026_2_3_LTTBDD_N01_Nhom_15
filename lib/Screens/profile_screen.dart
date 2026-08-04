import 'package:flutter/material.dart';
import '../core/app_state.dart';
import 'about_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: AppState.isDarkMode,
          builder: (context, isDark, _) {
            return SwitchListTile(
              title: Text(T.get('dark_mode')),
              secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              value: isDark,
              onChanged: (value) {
                AppState.toggleTheme();
              },
            );
          },
        ),
        const Divider(),
        ValueListenableBuilder<bool>(
          valueListenable: AppState.isVietnamese,
          builder: (context, isVi, _) {
            return SwitchListTile(
              title: Text(T.get('language')),
              secondary: const Icon(Icons.language),
              value: isVi,
              onChanged: (value) {
                AppState.toggleLanguage();
              },
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info),
          title: Text(T.get('about_us')),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: Text(
            T.get('logout'),
            style: const TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}