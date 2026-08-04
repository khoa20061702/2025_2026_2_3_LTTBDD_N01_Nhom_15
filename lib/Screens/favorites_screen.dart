import 'package:flutter/material.dart';
import '../core/favorites_manager.dart';
import '../core/app_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _favManager = FavoritesManager();

  @override
  Widget build(BuildContext context) {
    final favorites = _favManager.favorites;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            children: [
              const Icon(Icons.favorite, color: Colors.redAccent, size: 28),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    T.get('favorites'),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2575FC),
                    ),
                  ),
                  Text(
                    '${favorites.length} từ đã lưu',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border,
                          size: 80, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        'Chưa có từ yêu thích nào',
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Nhấn ❤️ khi học từ vựng để lưu lại',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final word = favorites[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          // Image
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
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              child: const Icon(Icons.image,
                                  size: 40, color: Colors.grey),
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
                                const SizedBox(height: 4),
                                Text(
                                  word.vietnamese,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Remove button
                          IconButton(
                            icon: const Icon(Icons.favorite,
                                color: Colors.redAccent, size: 26),
                            onPressed: () {
                              setState(() {
                                _favManager.remove(word);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '❌ Đã bỏ yêu thích "${word.english}"'),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.grey.shade700,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => _buildFallbackIcon(),
      );
    } else {
      return Image.network(
        imageUrl,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => _buildFallbackIcon(),
      );
    }
  }

  Widget _buildFallbackIcon() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: const Icon(Icons.image_not_supported, size: 35, color: Colors.grey),
    );
  }
}