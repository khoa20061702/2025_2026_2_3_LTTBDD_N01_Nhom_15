import 'package:flutter/material.dart';
import 'dart:math';
import '../models/topic.dart';
import '../models/word.dart';
import '../core/app_state.dart';

class QuizScreen extends StatefulWidget {
  final Topic topic;

  const QuizScreen({super.key, required this.topic});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  String? _selectedAnswer;
  late List<Word> _questions;
  late List<String> _options;

  @override
  void initState() {
    super.initState();
    _questions = List.from(widget.topic.words)..shuffle();
    _generateOptions();
  }

  void _generateOptions() {
    if (_currentIndex >= _questions.length) return;
    
    Word currentWord = _questions[_currentIndex];
    _options = [currentWord.vietnamese];
    
    // Get 3 other random meanings
    List<Word> otherWords = List.from(widget.topic.words)..remove(currentWord)..shuffle();
    for (int i = 0; i < min(3, otherWords.length); i++) {
      _options.add(otherWords[i].vietnamese);
    }
    
    _options.shuffle();
    _answered = false;
    _selectedAnswer = null;
  }

  void _checkAnswer(String selected) {
    if (_answered) return;
    
    setState(() {
      _answered = true;
      _selectedAnswer = selected;
      if (selected == _questions[_currentIndex].vietnamese) {
        _score++;
      }
    });
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _currentIndex++;
          _generateOptions();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(T.get('quiz'))),
        body: const Center(
          child: Text('Không có từ vựng nào trong chủ đề này.'),
        ),
      );
    }

    if (_currentIndex >= _questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text(T.get('quiz')),
          backgroundColor: const Color(0xFF6A11CB),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
              const SizedBox(height: 20),
              Text(
                '${T.get('score')}: $_score / ${_questions.length}', 
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF6A11CB)),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: Text(T.get('finish'), style: const TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2575FC),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    }

    Word currentWord = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${T.get('quiz')} - ${widget.topic.title}'),
        backgroundColor: const Color(0xFF6A11CB),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${T.get('question')} ${_currentIndex + 1}/${_questions.length}',
              style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      currentWord.english,
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF2575FC)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: _options.map((option) {
                  Color bgColor = Colors.white;
                  Color textColor = Colors.black87;
                  
                  if (_answered) {
                    if (option == currentWord.vietnamese) {
                      bgColor = Colors.green;
                      textColor = Colors.white;
                    } else if (option == _selectedAnswer) {
                      bgColor = Colors.redAccent;
                      textColor = Colors.white;
                    }
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                        foregroundColor: textColor,
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                      ),
                      onPressed: () => _checkAnswer(option),
                      child: Text(
                        option, 
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
