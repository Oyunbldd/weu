import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String code;
  var verificationId = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    print(verificationId);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Ямар код ирсэн бэ?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                const Text('Таньд ирсэн 6 оронтой нэг'),
                const Text('удаагийн нууц кодыг оруулна уу:'),
                const SizedBox(height: 20),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
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
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);

                        await auth.signInWithCredential(credential);
                        Get.toNamed('/mainScreen');
                      } catch (e) {}
                    },
                    child: const Text("Үргэлжлүүлэх"),
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
