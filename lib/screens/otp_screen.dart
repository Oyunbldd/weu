import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:weu/repository/authentication_repository.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = Get.put(AuthenticationRepository());
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String code;
  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Баталгаажуулалт',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 17,
          ),
          onPressed: () => Get.back(),
        ),
        bottomOpacity: 1.0,
        elevation: 0.25,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const SizedBox(height: 100),
                // const Text(
                //   'Ямар код ирсэн бэ?',
                //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 50),
                const Text(
                  'Таньд ирсэн 6 оронтой нэг удаагийн',
                  style: TextStyle(color: Colors.grey),
                ),
                const Text(
                  'нууц кодыг оруулна уу',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onCompleted: (pin) => setState(() {
                    isButtonActive = true;
                  }),
                  onChanged: (value) {
                    code = value;
                  },
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                  // controller: pinController,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: !isButtonActive
                        ? null
                        : () async =>
                            AuthenticationRepository.instance.verifyOTP(code),
                    child: const Text(
                      "Үргэлжлүүлэх",
                      style: TextStyle(fontSize: 12.5, color: Colors.white),
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
