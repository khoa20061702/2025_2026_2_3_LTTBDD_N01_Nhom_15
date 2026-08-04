import 'package:flutter/material.dart';
import 'word.dart';

class Topic {
  final String title;
  final IconData icon;
  final List<Word> words;
  final String? imageUrl;

  Topic({
    required this.title,
    required this.icon,
    required this.words,
    this.imageUrl,
  });
}
