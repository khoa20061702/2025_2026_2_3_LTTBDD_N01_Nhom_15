import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../models/word.dart';

List<Topic> topicList = [
  Topic(
    title: 'Động vật',
    icon: Icons.pets,
    imageUrl: 'assets/images/topic_animal.jpg',
    words: [
      Word(english: 'cat', vietnamese: 'con mèo', imageUrl: 'assets/images/word_cat.jpg'),
      Word(english: 'dog', vietnamese: 'con chó', imageUrl: 'assets/images/word_dog.jpg'),
      Word(english: 'bird', vietnamese: 'con chim', imageUrl: 'assets/images/word_bird.jpg'),
      Word(english: 'fish', vietnamese: 'con cá', imageUrl: 'assets/images/word_fish.jpg'),
      Word(english: 'elephant', vietnamese: 'con voi', imageUrl: 'assets/images/word_elephant.jpg'),
    ],
  ),
  Topic(
    title: 'Thực phẩm',
    icon: Icons.restaurant,
    imageUrl: 'assets/images/topic_food.jpg',
    words: [
      Word(english: 'rice', vietnamese: 'cơm', imageUrl: 'assets/images/word_rice.jpg'),
      Word(english: 'bread', vietnamese: 'bánh mì', imageUrl: 'assets/images/word_bread.jpg'),
      Word(english: 'noodle', vietnamese: 'mì', imageUrl: 'assets/images/word_noodle.jpg'),
      Word(english: 'egg', vietnamese: 'trứng', imageUrl: 'assets/images/word_egg.jpg'),
      Word(english: 'milk', vietnamese: 'sữa', imageUrl: 'assets/images/word_milk.jpg'),
    ],
  ),
  Topic(
    title: 'Du lịch',
    icon: Icons.flight,
    imageUrl: 'assets/images/topic_travel.jpg',
    words: [
      Word(english: 'airport', vietnamese: 'sân bay', imageUrl: 'assets/images/word_airport.jpg'),
      Word(english: 'hotel', vietnamese: 'khách sạn', imageUrl: 'assets/images/word_hotel.jpg'),
      Word(english: 'ticket', vietnamese: 'vé', imageUrl: 'assets/images/word_ticket.jpg'),
      Word(english: 'passport', vietnamese: 'hộ chiếu', imageUrl: 'assets/images/word_passport.jpg'),
      Word(english: 'map', vietnamese: 'bản đồ', imageUrl: 'assets/images/word_map.jpg'),
    ],
  ),
  Topic(
    title: 'Gia đình',
    icon: Icons.family_restroom,
    imageUrl: 'assets/images/topic_family.jpg',
    words: [
      Word(english: 'father', vietnamese: 'bố', imageUrl: 'assets/images/word_father.jpg'),
      Word(english: 'mother', vietnamese: 'mẹ', imageUrl: 'assets/images/word_mother.jpg'),
      Word(english: 'son', vietnamese: 'con trai', imageUrl: 'assets/images/word_son.jpg'),
      Word(english: 'daughter', vietnamese: 'con gái', imageUrl: 'assets/images/word_daughter.jpg'),
      Word(english: 'baby', vietnamese: 'em bé', imageUrl: 'assets/images/word_baby.jpg'),
    ],
  ),
  Topic(
    title: 'Trường học',
    icon: Icons.school,
    imageUrl: 'assets/images/topic_school.jpg',
    words: [
      Word(english: 'teacher', vietnamese: 'giáo viên', imageUrl: 'assets/images/word_teacher.jpg'),
      Word(english: 'student', vietnamese: 'học sinh', imageUrl: 'assets/images/word_student.jpg'),
      Word(english: 'book', vietnamese: 'quyển sách', imageUrl: 'assets/images/word_book.jpg'),
      Word(english: 'pen', vietnamese: 'cây bút', imageUrl: 'assets/images/word_pen.jpg'),
      Word(english: 'desk', vietnamese: 'bàn học', imageUrl: 'assets/images/word_desk.jpg'),
    ],
  ),
  Topic(
    title: 'Thể thao',
    icon: Icons.sports_soccer,
    imageUrl: 'assets/images/topic_sports.jpg',
    words: [
      Word(english: 'football', vietnamese: 'bóng đá', imageUrl: 'assets/images/word_football.jpg'),
      Word(english: 'basketball', vietnamese: 'bóng rổ', imageUrl: 'assets/images/word_basketball.jpg'),
      Word(english: 'swimming', vietnamese: 'bơi lội', imageUrl: 'assets/images/word_swimming.jpg'),
      Word(english: 'tennis', vietnamese: 'quần vợt', imageUrl: 'assets/images/word_tennis.jpg'),
      Word(english: 'running', vietnamese: 'chạy bộ', imageUrl: 'assets/images/word_running.jpg'),
    ],
  ),
  Topic(
    title: 'Màu sắc',
    icon: Icons.palette,
    imageUrl: 'assets/images/topic_colors.jpg',
    words: [
      Word(english: 'red', vietnamese: 'màu đỏ', imageUrl: 'assets/images/word_red.jpg'),
      Word(english: 'blue', vietnamese: 'màu xanh dương', imageUrl: 'assets/images/word_blue.jpg'),
      Word(english: 'green', vietnamese: 'màu xanh lá', imageUrl: 'assets/images/word_green.jpg'),
      Word(english: 'yellow', vietnamese: 'màu vàng', imageUrl: 'assets/images/word_yellow.jpg'),
      Word(english: 'black', vietnamese: 'màu đen', imageUrl: 'assets/images/word_black.jpg'),
    ],
  ),
  Topic(
    title: 'Thời tiết',
    icon: Icons.cloud,
    imageUrl: 'assets/images/topic_weather.jpg',
    words: [
      Word(english: 'sun', vietnamese: 'mặt trời', imageUrl: 'assets/images/word_sun.jpg'),
      Word(english: 'rain', vietnamese: 'mưa', imageUrl: 'assets/images/word_rain.jpg'),
      Word(english: 'wind', vietnamese: 'gió', imageUrl: 'assets/images/word_wind.jpg'),
      Word(english: 'snow', vietnamese: 'tuyết', imageUrl: 'assets/images/word_snow.jpg'),
      Word(english: 'cloud', vietnamese: 'đám mây', imageUrl: 'assets/images/word_cloud.jpg'),
    ],
  ),
];