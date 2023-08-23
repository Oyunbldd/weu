import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
    //checking name field screen
    // final bool? permissionScreen = prefs.getBool('permissionScreen');

    await Future.delayed(const Duration(seconds: 1));
    LocationPermission permission = await Geolocator.checkPermission();

    if (LocationPermission.always == permission ||
        LocationPermission.whileInUse == permission) {
      Get.toNamed('/mainScreen');
    }
    if (LocationPermission.unableToDetermine == permission ||
        LocationPermission.denied == permission) {
      Get.toNamed('/permissionScreen');
    }

    // Get.toNamed(permissionScreen == null ? '/permissionScreen' : '/mainScreen');
    // Get.toNamed('/loginScreen');
    // Get.toNamed('/mainScreen');
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Weu Logo'),
      ),
    );
  }
}
