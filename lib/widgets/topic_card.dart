import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../Screens/vocabulary_screen.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  const TopicCard({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip
          .antiAlias, // Ensures the image respects border radius
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VocabularyScreen(topic: topic),
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (topic.imageUrl != null)
              _buildImage(topic.imageUrl!)
            else
              _buildFallbackIcon(),

            // Dark gradient overlay to make text readable
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(
                      alpha: 0.7,
                    ),
                  ],
                ),
              ),
            ),

            // Title text at the bottom
            Positioned(
              bottom: 15,
              left: 10,
              right: 10,
              child: Text(
                topic.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) =>
                _buildFallbackIcon(),
      );
    } else {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) =>
                _buildFallbackIcon(),
      );
    }
  }

  Widget _buildFallbackIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          topic.icon,
          size: 55,
          color: Colors.blue,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
