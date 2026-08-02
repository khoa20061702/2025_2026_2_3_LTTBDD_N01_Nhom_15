import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';
import 'Screens/topic_detail_screen.dart';
import 'data/fake_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopicDetailScreen(topic: topicList[0]),
    );
  }
}
