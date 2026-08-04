import 'package:flutter/material.dart';
import '../core/app_state.dart';
import 'about_screen.dart';

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
      ],
    );
  }
}