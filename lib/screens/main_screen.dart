import 'package:flutter/material.dart';
import 'package:weu/views/contact_view.dart';
import 'package:weu/views/home_view.dart';
import 'package:weu/views/profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> body = [
    const HomeView(),
    const ContactView(),
    const ProfileView(),
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
          backgroundColor: Colors.white, // <-- This works for fixed
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 0.0, unselectedFontSize: 0.0,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
