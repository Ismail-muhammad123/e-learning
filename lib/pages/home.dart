import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/pages/cateories.dart';
import 'package:e_learning_app/pages/explore.dart';
import 'package:e_learning_app/pages/lessons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  switchCurrentPage(int index) => setState(() => currentIndex = index);
  int currentIndex = 0;
  List<Widget> pages = const [
    Explore(),
    Lessons(),
    Categories(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        elevation: 8.0,
        selectedItemColor: primaryColor,
        onTap: (value) => setState(() => currentIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: "Lessons",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
