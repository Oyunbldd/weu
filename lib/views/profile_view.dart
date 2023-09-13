import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:get/get.dart';
import 'package:weu/routes.dart';
import 'package:weu/screens/login_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  late DocumentSnapshot snapshot;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool readOnly = true;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    user = auth.currentUser!;
    _phoneController.text = user.phoneNumber!;
    getData();

    super.initState();
  }

  void getData() async {
    //use a Async-await function to get the data
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.phoneNumber)
        .get()
        .then((value) {
      _userNameController.text = value.data()!['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Миний профайл',
                    style:
                        TextStyle(fontSize: 22.5, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      readOnly = !readOnly;
                    }),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              const SizedBox(height: 10),
              const Text(
                'Нэр:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _userNameController,
                  keyboardType: TextInputType.phone,
                  readOnly: readOnly,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",
                  ),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Утасны дугаар:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  readOnly: readOnly,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Утасны дугаар",
                  ),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'И-Майл хаяг:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.phone,
                  readOnly: readOnly,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Visibility(
                visible: !readOnly,
                child: Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.red.withOpacity(0.75)),
                      child: const Text(
                        'Өөрчлөлтийг хадгалах',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        title: 'Та гарахдаа итгэлтэй байна уу ?',
                        titleTextStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        showCancelBtn: true,
                        onConfirmBtnTap: () async {
                          Navigator.pop(context);
                          await FirebaseAuth.instance.signOut();
                        },
                        onCancelBtnTap: () {},
                        confirmBtnText: 'Тийм',
                        cancelBtnText: 'Үгүй',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Гарах',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
