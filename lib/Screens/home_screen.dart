import 'package:flutter/material.dart';
import '../widgets/topic_card.dart';
class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount:2,
      crossAxisSpacing:16,
      mainAxisSpacing:16,
      children: const[
        TopicCard(
          title:'dong vat',
          icon:Icons.pets,
          ),
          TopicCard(
            title: ' thuc pham',
            icon:Icons.restaurant,
          ),
          TopicCard(
            title:'du lich',
            icon:Icons.flight,
          ),
          TopicCard(title:'gia dinh',
          icon:Icons.family_restroom,
          ),
          TopicCard(title:'truong hoc',
          icon:Icons.school,
          ),
          TopicCard(title:'the thao',
          icon:Icons.sports_soccer,
          ),
      ]
    );
  }
}