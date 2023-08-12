import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _opacity = 0.1;
  double _opacity1 = 0.2;
  double _opacity2 = 0.3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(175),
                    color: Colors.red.withOpacity(_opacity),
                  ),
                  child: const SizedBox(width: 350, height: 350),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Colors.red.withOpacity(_opacity1),
                  ),
                  child: const SizedBox(width: 300, height: 300),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Colors.red.withOpacity(_opacity2),
                  ),
                  child: const SizedBox(width: 250, height: 250),
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          // side: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    onLongPress: () async {
                      Timer(const Duration(seconds: (3)), () {
                        setState(() {
                          if (_opacity == 0) {
                            _opacity = 0.1;
                            _opacity1 = 0.2;
                            _opacity2 = 0.3;
                          } else {
                            _opacity = 0;
                            _opacity1 = 0;
                            _opacity2 = 0;
                          }
                        });
                      });
                    },
                    onPressed: () {},
                    child: const Text(
                      'HELP ME!',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
