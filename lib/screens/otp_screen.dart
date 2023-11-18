import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

  String phoneNumber = Get.arguments[0];

  int resendTime = 60;
  late Timer countDownTimer;

  startTimer() {
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        countDownTimer.cancel();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                const SizedBox(height: 50),
                Text(
                  'Таньд ирсэн 6 оронтой нэг удаагийн',
                  style: GoogleFonts.rubik(color: Colors.grey),
                ),
                Text(
                  'нууц кодыг оруулна уу',
                  style: GoogleFonts.rubik(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Pinput(
                  length: 6,
                  showCursor: true,
                  autofocus: true,
                  onCompleted: (pin) => setState(() {
                    isButtonActive = true;
                  }),
                  onChanged: (value) {
                    code = value;
                    if (code.length < 6) {
                      setState(() {
                        isButtonActive = false;
                      });
                    }
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
                    child: Text(
                      "Үргэлжлүүлэх",
                      style: GoogleFonts.rubik(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: resendTime > 0
                      ? Text(
                          "Шинэ код $resendTime секундын дараа авах боломжтой.",
                          style: GoogleFonts.rubik(
                            color: Colors.grey,
                            fontSize: 12.5,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            AuthenticationRepository.instance
                                .phoneAuthentication(phoneNumber);
                            setState(() {
                              resendTime = 60;
                            });
                            startTimer();
                          },
                          child: Text(
                            "Код дахин авах уу?",
                            style: GoogleFonts.rubik(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
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
