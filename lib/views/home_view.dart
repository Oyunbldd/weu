import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:timer_count_down/timer_count_down.dart';

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
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  int _count = 3;
  double _width = 200, _heigth = 200;
  bool deleteDoc = false;

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

  Future _showDialog() {
    return showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.red.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 75,
            horizontal: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.25,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.25,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(75),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.25,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(75),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Countdown(
                        seconds: 3,
                        build: (
                          BuildContext context,
                          double time,
                        ) =>
                            Text(
                          time.floor().toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        interval: const Duration(milliseconds: 100),
                        onFinished: () {
                          Get.toNamed('/emergencyScreen');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Хүсэлт илгээж байна',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: JumpingDots(
                      color: Colors.white,
                      radius: 2.5,
                      numberOfDots: 3,
                      animationDuration: const Duration(milliseconds: 250),
                    ),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    setState(() {
                      _count = 3;
                      _width = 200;
                      _heigth = 200;
                      deleteDoc = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_width / 2),
                      ),
                    ),
                  ),
                  child: const Text(
                    "I AM SAFE.",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
          Text(
            'Танд тусламж',
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: _count == 0 ? Colors.white : Colors.black),
          ),
          Text(
            'хэрэгтэй байна уу?',
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: _count == 0 ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 30),
          Container(
            height: 275,
            width: 275,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              color: Colors.red.withOpacity(0.75),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  width: _width,
                  height: _heigth,
                  duration: const Duration(milliseconds: 250),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_width / 2),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _width = _width + 25;
                        _heigth = _heigth + 25;
                        _count -= 1;
                      });

                      if (_count == 0) {
                        _showDialog();
                        Position? location = await _determinePosition();
                        if (location != null) {
                          final data = {
                            "longitude": location.longitude,
                            "latitue": location.latitude
                          };
                          firestore.collection('locations').add(data).then(
                            (DocumentReference value) {
                              // If user clicking cancelled button delete data from db

                              if (deleteDoc) {
                                firestore
                                    .collection('locations')
                                    .doc(value.id)
                                    .delete();
                                setState(() {
                                  deleteDoc = false;
                                });
                              }
                            },
                          );
                        }
                      }
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
          const SizedBox(height: 20),
          Text(
            'Та $_count удаа товшоорой !',
            style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.bold,
                color: _count == 0 ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
