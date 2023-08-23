import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.withOpacity(0.25),
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Enable Location Access',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 25),
              const Text(
                'lorem ipsum  lorem ipisum lorem ipsum',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const Text(
                'lorem ipsum  lorem ip',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 25, top: 15),
                child: ElevatedButton(
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
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Allow',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    // await Geolocator.checkPermission();
                    await Geolocator.requestPermission();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('permissionScreen', false);
                    // Get.toNamed('/mainScreen');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
