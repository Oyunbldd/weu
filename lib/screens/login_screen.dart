import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController;
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneController.addListener(() {
      bool buttonType = _phoneController.text.length > 8;

      setState(() {
        isButtonActive = buttonType;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Таны дугаар хэд вэ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              const Text('Та доор утасны дугаараа оруулна уу.'),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.25, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const CountryCodePicker(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      flagWidth: 20,
                      onChanged: print,
                      initialSelection: 'MN',
                      favorite: ['+976', 'MN'],
                      showCountryOnly: false,
                      alignLeft: false,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.25, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _phoneController,
                      onChanged: (String text) {
                        _phoneController.text = text;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Утасны дугаар",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isButtonActive ? () {} : null,
                  // onPressed: () {
                  //   // Navigator.pushNamed(context, 'verify');
                  // },
                  child: const Text("Нэвтрэх"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
