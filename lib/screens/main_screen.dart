import 'package:flutter/material.dart';
import 'package:weu/views/home_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> body = [
    const HomeView(),
    Icon(Icons.notifications),
    Icon(Icons.home),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: body[_currentIndex],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
          ],
        ),
      ),
    );
  }
}
