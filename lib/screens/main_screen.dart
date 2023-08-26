import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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
  var verificationId = Get.arguments[0];

  List<Widget?> body = [
    const HomeView(),
    const ContactView(),
    const ProfileView(),
  ];

  //bustaj orj irsen uyd checkleh

  Widget getPermission() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Unable to connect',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black.withOpacity(0.75)),
          ),
          const SizedBox(height: 20),
          const Text(
            'To use WeU, you need to enable your location',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Go to Settings > WeU > Location > Enable',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            'Location While Using the App',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 50),
          Container(
            height: 45,
            margin: const EdgeInsets.only(bottom: 25, top: 15),
            child: ElevatedButton(
              onPressed: () async {
                await Geolocator.openAppSettings();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.red.withOpacity(0.75),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: const Text('Open Settings'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: _currentIndex == 0 && verificationId == 'denied'
                  ? getPermission()
                  : body[_currentIndex],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
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
