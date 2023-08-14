import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//Ene screen deer uuchlult orno
//Zuvun location permission ene hesegt avna
//This screen called one time.
//locale storage deer hadgalah umnun neesen eshiig

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                height: 75,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: const Text('Picture'),
              ),
              const SizedBox(height: 25),
              const Text(
                'Allow WeU to access your',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                'camera and location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Icon(
                    Icons.photo_album,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How you'll use this",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'To take photos, record videos and preview',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'visual and audio effects.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Icon(
                    Icons.message,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How we'll use this",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'To show you previews of visual and',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'audio effects.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How these settings work",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'You can change your choices at any time in',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'your decice settings. If you allow access now,',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "you won't have to allow it again.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              const Divider(height: 2, thickness: 2),
              Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 25, top: 15),
                child: ElevatedButton(
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  onPressed: () async {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
