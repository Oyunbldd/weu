import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weu/screens/login_screen.dart';
import 'package:weu/screens/main_screen.dart';
import 'package:weu/screens/required_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables;
  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  //Check user loaction permission
  _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (LocationPermission.always == permission ||
        LocationPermission.whileInUse == permission) {
      Get.offAll(const MainScreen(), arguments: ['allowed']);
    } else {
      Get.offAll(const MainScreen(), arguments: ['denied']);
    }
  }

//Detector of what screen calling next
  _navigationToNextScreen(String uid, String phoneNumber) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final bool requiredScreen = prefs.getBool('requiredScreen') ?? true;
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get();

    if (data.data() == null) {
      Get.offAll(
        const RequiredScreen(),
        arguments: [
          uid,
          phoneNumber,
        ],
      );
    } else {
      _checkPermission();
    }
    // _checkPermission();
  }

  _setInitialScreen(User? user) {
    // user == null ? Get.offAll(() => const LoginScreen()) : _checkPermission();
    user == null
        ? Get.offAll(() => const LoginScreen())
        : _navigationToNextScreen(
            firebaseUser.value!.uid, firebaseUser.value!.phoneNumber!);
  }

  //Main Function
  void phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid');
        } else {
          print(e);
          Get.snackbar('Error', 'Something went wrong. Try again.');
        }
      },
    );
  }

  verifyOTP(String otp) async {
    var credential = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp),
    );
    return credential.user == null
        ? Get.offAll(() => const LoginScreen())
        : _navigationToNextScreen(
            firebaseUser.value!.uid, firebaseUser.value!.phoneNumber!);
  }
}
