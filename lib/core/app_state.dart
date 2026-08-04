import 'package:flutter/material.dart';

class AppState {
  // Theme state: false = light, true = dark
  static final ValueNotifier<bool> isDarkMode = ValueNotifier(false);
  
  // Language state: true = Vietnamese, false = English
  static final ValueNotifier<bool> isVietnamese = ValueNotifier(true);

  static void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  static void toggleLanguage() {
    isVietnamese.value = !isVietnamese.value;
  }
}

// Simple translation helper
class T {
  static String get(String key) {
    bool isVi = AppState.isVietnamese.value;
    
    Map<String, Map<String, String>> translations = {
      'login': {
        'en': 'Login',
        'vi': 'Đăng nhập',
      },
      'home': {
        'en': 'Home',
        'vi': 'Trang chủ',
      },
      'favorites': {
        'en': 'Favorites',
        'vi': 'Yêu thích',
      },
      'profile': {
        'en': 'Profile',
        'vi': 'Hồ sơ',
      },
      'app_title': {
        'en': 'Vocab Learning',
        'vi': 'Học Từ Vựng',
      },
      'hello': {
        'en': 'Hello!',
        'vi': 'Xin chào!',
      },
      'what_to_learn': {
        'en': 'What do you want to learn today?',
        'vi': 'Hôm nay bạn muốn học chủ đề gì?',
      },
      'dark_mode': {
        'en': 'Dark Mode',
        'vi': 'Chế độ tối',
      },
      'language': {
        'en': 'Language (EN/VI)',
        'vi': 'Ngôn ngữ (EN/VI)',
      },
      'about_us': {
        'en': 'About Us',
        'vi': 'Về chúng tôi',
      },
      'team_15': {
        'en': 'Team 15 - Developers',
        'vi': 'Nhóm 15 - Nhóm phát triển',
      },
      'email': {
        'en': 'Email',
        'vi': 'Email',
      },
      'password': {
        'en': 'Password',
        'vi': 'Mật khẩu',
      },
      'dont_have_account': {
        'en': 'Don\'t have an account? Sign Up',
        'vi': 'Chưa có tài khoản? Đăng ký',
      },
    };

    return translations[key]?[isVi ? 'vi' : 'en'] ?? key;
  }
}

