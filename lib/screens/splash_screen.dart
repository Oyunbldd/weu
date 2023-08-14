import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigationtoNextScreen();
  }

  _navigationtoNextScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool permissionScreen = prefs.getBool('permissionScreen') ?? false;
    print(permissionScreen);
    Get.toNamed(!permissionScreen ? '/mainScreen' : '/splashScreen');
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Weu Logo'),
      ),
    );
  }
}
