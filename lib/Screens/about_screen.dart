import 'package:flutter/material.dart';
import '../core/app_state.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(T.get('about_us')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.groups,
              size: 80,
              color: Color(0xFF2575FC),
            ),
            const SizedBox(height: 10),
            Text(
              T.get('team_15'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildMemberCard('Nguyễn Đăng Khoa', 'assets/images/ava_khoa.jpg'),
            const SizedBox(height: 16),
            _buildMemberCard('Vũ Phan Hoàng Sơn', 'assets/images/ava_son.jpg'),
            const SizedBox(height: 16),
            _buildMemberCard('Phạm Công Vinh', 'assets/images/ava_vinh.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(String name, String avatarPath) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(avatarPath),
              onBackgroundImageError: (exception, stackTrace) {},
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
