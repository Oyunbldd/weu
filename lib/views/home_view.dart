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
  double _widht = 200, _heigth = 200;

  Future<Position?> _determinePosition() async {
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
        await Geolocator.openAppSettings();
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
      // await Geolocator.openAppSettings();
      // Check permission
      // if (permission == LocationPermission.denied ||
      //     permission == LocationPermission.deniedForever) {
      //   return Future.error(
      //       'Location permissions are permanently denied, we cannot request permissions.');
      // }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
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
          // const SizedBox(height: 10),
          // const Text(
          //   'Товчоо удаан дараарай',
          //   style: TextStyle(
          //     fontSize: 10,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.black54,
          //   ),
          // ),
          const SizedBox(height: 30),
          Container(
            height: 275,
            width: 275,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                // border: Border.all(width: 0.5, color: Colors.grey),
                color: Colors.red.withOpacity(
                  0.75,
                )),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  width: _widht,
                  height: _heigth,
                  duration: const Duration(milliseconds: 250),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_widht / 2),
                        ),
                      ),
                    ),
                    onLongPress: () async {
                      Position? location = await _determinePosition();
                      setState(() {
                        _showAnimation = true;
                      });
                      if (location != null) {
                        final data = {
                          "longitude": location.longitude,
                          "latitue": location.latitude
                        };
                        firestore
                            .collection('locations')
                            .add(data)
                            .then((value) => {
                                  // Timer(const Duration(seconds: (2)), () {
                                  //   Get.toNamed('/emergencyScreen');
                                  // }),
                                  Get.toNamed('/emergencyScreen'),
                                  setState(() {
                                    _showAnimation = false;
                                  })
                                });
                      } else {
                        setState(() {
                          _showAnimation = false;
                        });
                      }
                    },
                    onPressed: () {
                      setState(() {
                        // if (_showAnimation) _showAnimation = false;
                        _widht = _widht + 25;
                        _heigth = _heigth + 25;
                      });
                    },
                    child: Icon(
                      Icons.ads_click_rounded,
                      color: Colors.red.withOpacity(0.75),
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
