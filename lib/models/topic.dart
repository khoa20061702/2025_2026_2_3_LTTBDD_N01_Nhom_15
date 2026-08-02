import 'package:flutter/material.dart';
import 'word.dart';

class Topic {
  final String title;
  final IconData icon;
  final List<Word> words;

  Topic({required this.title, required this.icon, required this.words});
}
