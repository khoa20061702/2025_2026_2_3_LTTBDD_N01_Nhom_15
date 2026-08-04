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
      'register': {
        'en': 'Register',
        'vi': 'Đăng ký',
      },
      'register_subtitle': {
        'en': 'Create your account to start learning',
        'vi': 'Tạo tài khoản để bắt đầu học ngay',
      },
      'full_name': {
        'en': 'Full Name',
        'vi': 'Họ và tên',
      },
      'confirm_password': {
        'en': 'Confirm Password',
        'vi': 'Xác nhận mật khẩu',
      },
      'already_have_account': {
        'en': 'Already have an account? Login',
        'vi': 'Đã có tài khoản? Đăng nhập',
      },
      'register_success': {
        'en': 'Registration successful! Welcome!',
        'vi': 'Đăng ký thành công! Chào mừng bạn!',
      },
      'logout': {
        'en': 'Logout',
        'vi': 'Đăng xuất',
      },
      'quiz': {
        'en': 'Quiz',
        'vi': 'Trắc nghiệm',
      },
      'score': {
        'en': 'Score',
        'vi': 'Điểm',
      },
      'finish': {
        'en': 'Finish',
        'vi': 'Hoàn thành',
      },
      'question': {
        'en': 'Question',
        'vi': 'Câu hỏi',
      },
    };

    return translations[key]?[isVi ? 'vi' : 'en'] ?? key;
  }
}

