import 'package:flutter/material.dart';
import 'dart:math';
import '../models/topic.dart';
import '../models/word.dart';
import '../core/favorites_manager.dart';

class FlashcardScreen extends StatefulWidget {
  final Topic topic;

  const FlashcardScreen({
    super.key,
    required this.topic,
  });

  @override
  State<FlashcardScreen> createState() =>
      _FlashcardScreenState();
}

class _FlashcardScreenState
    extends State<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  int _currentIndex = 0;
  bool _isFlipped = false;
  final _favManager = FavoritesManager();

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _flipAnimation =
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _flipController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  List<Word> get words => widget.topic.words;
  Word get currentWord => words[_currentIndex];

  void _flipCard() {
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  void _nextCard() {
    if (_currentIndex < words.length - 1) {
      _flipController.reset();
      setState(() {
        _currentIndex++;
        _isFlipped = false;
      });
    }
  }

  void _prevCard() {
    if (_currentIndex > 0) {
      _flipController.reset();
      setState(() {
        _currentIndex--;
        _isFlipped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFav = _favManager.isFavorite(
      currentWord,
    );
    final progress =
        (_currentIndex + 1) / words.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: Text(widget.topic.title),
        backgroundColor: const Color(0xFF6A11CB),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Center(
              child: Text(
                '${_currentIndex + 1} / ${words.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor:
                const AlwaysStoppedAnimation<
                  Color
                >(Color(0xFF6A11CB)),
          ),

          const SizedBox(height: 20),

          // Hint text
          Text(
            _isFlipped
                ? 'Tiếng Việt'
                : 'Nhấn thẻ để lật xem nghĩa',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 16),

          // Flashcard
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: GestureDetector(
                onTap: _flipCard,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    final angle =
                        _flipAnimation.value * pi;
                    final isFrontVisible =
                        angle < pi / 2;

                    return Transform(
                      alignment: Alignment.center,
                      transform:
                          Matrix4.identity()
                            ..setEntry(
                              3,
                              2,
                              0.001,
                            )
                            ..rotateY(angle),
                      child: isFrontVisible
                          ? _buildFrontCard()
                          : Transform(
                              alignment: Alignment
                                  .center,
                              transform:
                                  Matrix4.identity()
                                    ..rotateY(pi),
                              child:
                                  _buildBackCard(),
                            ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Favorite button
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _favManager.toggle(
                      currentWord,
                    );
                  });
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav
                            ? ' Đã bỏ yêu thích "${currentWord.english}"'
                            : 'Đã thêm "${currentWord.english}" vào yêu thích!',
                      ),
                      duration: const Duration(
                        seconds: 1,
                      ),
                      behavior: SnackBarBehavior
                          .floating,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                              10,
                            ),
                      ),
                      backgroundColor: isFav
                          ? Colors.grey.shade700
                          : Colors.redAccent,
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                  decoration: BoxDecoration(
                    color: isFav
                        ? Colors.red.shade50
                        : Colors.grey.shade100,
                    borderRadius:
                        BorderRadius.circular(30),
                    border: Border.all(
                      color: isFav
                          ? Colors.redAccent
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isFav
                            ? Icons.favorite
                            : Icons
                                  .favorite_border,
                        color: isFav
                            ? Colors.redAccent
                            : Colors.grey,
                        size: 22,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isFav
                            ? 'Đã yêu thích'
                            : 'Yêu thích',
                        style: TextStyle(
                          color: isFav
                              ? Colors.redAccent
                              : Colors.grey,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                // Previous
                ElevatedButton.icon(
                  onPressed: _currentIndex > 0
                      ? _prevCard
                      : null,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  label: const Text('Trước'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF6A11CB,
                    ),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                            12,
                          ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                  ),
                ),

                // Flip indicator
                Column(
                  children: [
                    Icon(
                      Icons.touch_app,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                    Text(
                      'Nhấn để lật',
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                // Next
                ElevatedButton.icon(
                  onPressed:
                      _currentIndex <
                          words.length - 1
                      ? _nextCard
                      : null,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  label: const Text('Tiếp'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF2575FC,
                    ),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                            12,
                          ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6A11CB),
            Color(0xFF2575FC),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF6A11CB,
            ).withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          // Word image (if available)
          if (currentWord.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(
                16,
              ),
              child: _buildImage(
                currentWord.imageUrl!,
                160,
                130,
              ),
            ),
          const SizedBox(height: 24),
          const Text(
            'TIẾNG ANH',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            currentWord.english,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.12,
            ),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: const Color(
            0xFF6A11CB,
          ).withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          if (currentWord.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(
                16,
              ),
              child: _buildImage(
                currentWord.imageUrl!,
                160,
                130,
              ),
            ),
          const SizedBox(height: 24),
          const Text(
            'TIẾNG VIỆT',
            style: TextStyle(
              color: Color(0xFF6A11CB),
              fontSize: 13,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            currentWord.vietnamese,
            style: const TextStyle(
              color: Color(0xFF2575FC),
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            currentWord.english,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(
    String imageUrl,
    double width,
    double height,
  ) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) =>
            const SizedBox.shrink(),
      );
    }
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (c, e, s) =>
          const SizedBox.shrink(),
    );
  }
}
