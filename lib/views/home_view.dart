import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

//Using geolocator

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _showAnimation = false;
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
                    Timer(const Duration(seconds: (2)), () {
                      setState(() {
                        _showAnimation = true;
                      });
                      Get.toNamed('/emergencyScreen');
                    });
                  },
                  onPressed: () {
                    setState(() {
                      if (_showAnimation) _showAnimation = false;
                    });
                  },
                  child: const Text(
                    'HELP ME!',
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
