import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../models/word.dart';

List<Topic> topicList = [
  Topic(
    title: 'dong vat',
    icon: Icons.pets,
    words: [
      Word(english: 'cat', vietnamese: 'con meo'),
      Word(english: 'dog', vietnamese: 'con cho'),
      Word(english: 'bird', vietnamese: 'con chim'),
      Word(english: 'fish', vietnamese: 'con ca'),
      Word(english: 'elephant', vietnamese: 'con voi'),
    ],
  ),
  Topic(
    title: 'thuc pham',
    icon: Icons.restaurant,
    words: [
      Word(english: 'rice', vietnamese: 'com'),
      Word(english: 'bread', vietnamese: 'banh mi'),
      Word(english: 'noodle', vietnamese: 'mi'),
      Word(english: 'egg', vietnamese: 'trung'),
      Word(english: 'milk', vietnamese: 'sua'),
    ],
  ),
  Topic(
    title: 'du lich',
    icon: Icons.flight,
    words: [
      Word(english: 'airport', vietnamese: 'san bay'),
      Word(english: 'hotel', vietnamese: 'khach san'),
      Word(english: 'ticket', vietnamese: 've'),
      Word(english: 'passport', vietnamese: 'ho chieu'),
      Word(english: 'map', vietnamese: 'ban do'),
    ],
  ),