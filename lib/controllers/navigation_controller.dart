// lib/controllers/navigation_controller.dart

import 'package:flutter/material.dart';
import 'package:project/presentation/pages/past_future_event_list_page.dart';
import 'package:project/presentation/pages/home_page.dart';
import 'package:project/presentation/pages/past_event_list_page.dart';

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  _NavigationControllerState createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    PastFutureEventListPage(),
    //Delete this:
    PastEventListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add_rounded),
            label: 'Future Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Past Events',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            Colors.purple,
        unselectedItemColor: Colors.purple.shade200,
        onTap: _onItemTapped,
      ),
    );
  }
}
