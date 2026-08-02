import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../models/word.dart';

class TopicDetailScreen extends StatefulWidget {
  final Topic topic;

  const TopicDetailScreen({super.key, required this.topic});

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 2 Tab: Flashcard và Trắc nghiệm
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.topic.title),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.style), text: 'Flashcard'),
              Tab(icon: Icon(Icons.quiz), text: 'Trắc nghiệm'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TAB 1: FLASHCARD
            _buildFlashcardTab(widget.topic.words),

            // TAB 2: QUIZ (TRẮC NGHIỆM)
            _buildQuizTab(widget.topic.words),
          ],
        ),
      ),
    );
  }

  // Giao diện Tab Flashcard (Bấm/Lật thẻ để xem nghĩa)
  Widget _buildFlashcardTab(List<Word> words) {
    if (words.isEmpty) {
      return const Center(child: Text('Chưa có từ vựng nào trong chủ đề này'));
    }

    return PageView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];
        return _FlashcardItem(
          word: word,
          index: index + 1,
          total: words.length,
        );
      },
    );
  }

  // Giao diện Tab Quiz Trắc nghiệm đơn giản
  Widget _buildQuizTab(List<Word> words) {
    if (words.isEmpty) {
      return const Center(child: Text('Không đủ từ vựng để tạo câu hỏi'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Câu ${index + 1}: Từ "${word.english}" nghĩa là gì?',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Chính xác! ${word.english} = ${word.vietnamese}',
                        ),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: Text(word.vietnamese),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget thẻ Flashcard có hiệu ứng bấm lật xem nghĩa
class _FlashcardItem extends StatefulWidget {
  final Word word;
  final int index;
  final int total;

  const _FlashcardItem({
    required this.word,
    required this.index,
    required this.total,
  });

  @override
  State<_FlashcardItem> createState() => _FlashcardItemState();
}

class _FlashcardItemState extends State<_FlashcardItem> {
  bool showVietnamese = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            showVietnamese = !showVietnamese; // Đổi trạng thái hiển thị
          });
        },
        child: Container(
          width: 300,
          height: 400,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: showVietnamese ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Stack(
            children: [
              // Đếm số trang (Ví dụ: 1/5)
              Positioned(
                top: 15,
                right: 15,
                child: Text(
                  '${widget.index}/${widget.total}',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              // Nội dung thẻ
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      showVietnamese
                          ? widget.word.vietnamese
                          : widget.word.english,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: showVietnamese ? Colors.blue : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      showVietnamese
                          ? '(Tiếng Việt)'
                          : '(Chạm vào thẻ để xem nghĩa)',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
