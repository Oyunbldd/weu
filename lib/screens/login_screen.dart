import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weu/repository/authentication_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(AuthenticationRepository());

  final TextEditingController _phoneController = TextEditingController();
  CountryCode _countryCode = CountryCode(dialCode: '+976');

  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      bool buttonType = _phoneController.text.length > 7;
      setState(() {
        isButtonActive = buttonType;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Таны дугаар хэд вэ?',
                  style: GoogleFonts.rubik(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Та доор утасны дугаараа оруулна уу',
                  style: GoogleFonts.rubik(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.25,
                          color: Colors.blue.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CountryCodePicker(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        flagWidth: 20,
                        onChanged: (CountryCode countryCode) {
                          setState(() {
                            _countryCode = countryCode;
                          });
                        },
                        initialSelection: 'MN',
                        favorite: const ['+976', 'MN'],
                        showCountryOnly: false,
                        alignLeft: false,
                        textStyle: GoogleFonts.rubik(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.25,
                          color: Colors.blue.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Утасны дугаар",
                        ),
                        style: GoogleFonts.rubik(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    // border: Border.all(width: 1),
                    color: !isButtonActive
                        ? Colors.grey.withOpacity(0.1)
                        : Colors.blue.withOpacity(1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // backgroundColor: Colors.blue.withOpacity(0.5),
                    ),
                    onPressed: !isButtonActive
                        ? null
                        : () async {
                            AuthenticationRepository.instance
                                .phoneAuthentication(
                              '$_countryCode ${_phoneController.text}',
                              // _phoneController.text.trim(),
                            );
                            Get.toNamed('/otpScreen', arguments: [
                              '$_countryCode ${_phoneController.text}'
                            ]);
                          },
                    child: Text(
                      "Нэвтрэх",
                      style: GoogleFonts.rubik(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
