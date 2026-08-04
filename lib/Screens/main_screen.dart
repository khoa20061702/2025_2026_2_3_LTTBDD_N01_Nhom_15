import 'package:flutter/material.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import '../core/app_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() =>  _MainScreenState();
}

class  _MainScreenState extends State <MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    HomeScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(T.get('app_title')),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:(index){
          setState((){
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: T.get('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: T.get('favorites'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: T.get('profile'),
          ),
        ]
      )
    );
  }
}