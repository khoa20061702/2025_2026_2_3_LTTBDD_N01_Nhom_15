import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../core/favorites_manager.dart';

class VocabularyScreen extends StatefulWidget {
  final Topic topic;

  const VocabularyScreen({super.key, required this.topic});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final _favManager = FavoritesManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.title),
        backgroundColor: const Color(0xFF6A11CB),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.topic.words.length,
        itemBuilder: (context, index) {
          final word = widget.topic.words[index];
          final isFav = _favManager.isFavorite(word);

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                // Image or placeholder
                if (word.imageUrl != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: _buildImage(word.imageUrl!),
                  )
                else
                  Container(
                    width: 110,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),

                const SizedBox(width: 14),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word.english,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2575FC),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        word.vietnamese,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                // Favorite button
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey(isFav),
                        color: isFav ? Colors.redAccent : Colors.grey,
                        size: 28,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _favManager.toggle(word);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFav
                                ? '❌ Đã bỏ yêu thích "${word.english}"'
                                : '❤️ Đã thêm "${word.english}" vào yêu thích!',
                          ),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: isFav
                              ? Colors.grey.shade700
                              : Colors.redAccent,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        width: 110,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallbackIcon(),
      );
    } else {
      return Image.network(
        imageUrl,
        width: 110,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallbackIcon(),
      );
    }
  }

  Widget _buildFallbackIcon() {
    return Container(
      width: 110,
      height: 100,
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
    );
  }
}

