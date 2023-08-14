import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Using geolocator

//Ened location permission detect hiine
//Firebase firestore ruu real time aar location goo shidne;
//1.geolocator high level location g ashiglna
//2.locationgoo firestore ruu realtime aar bichne
//3.Request in amjilttai bol Emergency_screen ruu shidne

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final storage = FirebaseStorage.instance;
  bool _showAnimation = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Танд тусламж',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const Text(
          'хэрэгтэй байна уу?',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Товчоо удаан дараарай',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 350,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _showAnimation
                  ? Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(175),
                        color: Colors.red.withOpacity(0.2),
                      ),
                    )
                      .animate(
                        delay: 700.ms,
                        onPlay: (controller) => controller.repeat(),
                      )
                      .fadeOut(delay: 1300.ms)
                  : SizedBox(),
              _showAnimation
                  ? Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.red.withOpacity(0.1),
                      ),
                    )
                      .animate(
                        delay: 600.ms,
                        onPlay: (controller) => controller.repeat(),
                      )
                      .fadeOut(delay: 1200.ms)
                  : SizedBox(),
              _showAnimation
                  ? Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(125),
                        color: Colors.red.withOpacity(0.3),
                      ),
                    )
                      .animate(
                        delay: 500.ms,
                        onPlay: (controller) => controller.repeat(),
                      )
                      .fadeOut(delay: 1000.ms)
                  : SizedBox(),
              SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                  onLongPress: () async {
                    setState(() {
                      _showAnimation = true;
                    });
                    Position location = await _determinePosition();
                    final data = {
                      "longitude": location.longitude,
                      "latitue": location.latitude
                    };
                    firestore
                        .collection('locations')
                        .add(data)
                        .then((value) => {
                              print(value),
                            });

                    // Timer(const Duration(seconds: (2)), () {
                    //   setState(() {
                    //     _showAnimation = true;
                    //   });
                    // Get.toNamed('/emergencyScreen');
                    // });
                  },
                  onPressed: () {
                    setState(() {
                      if (_showAnimation) _showAnimation = false;
                    });
                  },
                  child: const Text(
                    'Тусламж!',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
