import 'dart:developer';
import 'dart:ffi';

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

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 1;
  late String verificationId;

  List<Widget?> body = [
    const ContactView(),
    const HomeView(),
    const ProfileView(),
  ];
  @override
  void initState() {
    checkPermission();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (LocationPermission.always == permission ||
        LocationPermission.whileInUse == permission) {
      setState(() {
        verificationId = "allowed";
      });
    }
    if (LocationPermission.denied == permission) {
      setState(() {
        verificationId = "denied";
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      checkPermission();
    }
  }

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
              child: _currentIndex == 1 && verificationId == 'denied'
                  ? getPermission()
                  : body[_currentIndex],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 0.33,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
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
                  icon: Icon(Icons.person, size: 27),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 27),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 27),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
