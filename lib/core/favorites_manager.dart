import '../models/word.dart';

class FavoritesManager {
  // Singleton pattern
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  // List of favorite words
  final List<Word> _favorites = [];

  List<Word> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Word word) {
    return _favorites.any((w) => w.english == word.english);
  }

  void toggle(Word word) {
    if (isFavorite(word)) {
      _favorites.removeWhere((w) => w.english == word.english);
    } else {
      _favorites.add(word);
    }
  }

  void remove(Word word) {
    _favorites.removeWhere((w) => w.english == word.english);
  }
}
