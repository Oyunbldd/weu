// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(user.phoneNumber)
      .collection('contacts')
      .snapshots();

  bool buttonHide = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _phoneNameController = TextEditingController();

  final List<String> selectingTypes = [
    'Гэр бүлийн гишүүн',
    'Хамаатан садан',
    'Найз нөхөд',
  ];

  String selectedValue = '';

  @override
  void initState() {
    user = auth.currentUser!;

    super.initState();
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Миний контакт',
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontSize: 22.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        builder: (BuildContext context) {
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              padding: const EdgeInsets.only(
                                  top: 0, left: 20, right: 20, bottom: 20),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Контакт нэмэх',
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 13,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        hint: Text(
                                          'Таны хэн болох ?',
                                          style: GoogleFonts.rubik(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        items: selectingTypes
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: GoogleFonts.rubik(
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value.toString();
                                          });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 10),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.25,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextField(
                                          controller: _phoneNameController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Хадгалах нэр",
                                          ),
                                          style: GoogleFonts.rubik(
                                            fontSize: 13,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.25,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextField(
                                          controller: _phoneController,
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Утасны дугаар",
                                          ),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 125,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedValue = '';
                                                });
                                                _phoneController.text = '';
                                                _phoneNameController.text = '';
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                              child: Text(
                                                'Болих',
                                                style: GoogleFonts.rubik(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                // style: TextStyle(
                                                //   color: Colors.grey,
                                                //   fontWeight: FontWeight.bold,
                                                // ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 125,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (_phoneController
                                                            .text.length >
                                                        7 &&
                                                    selectedValue.isNotEmpty &&
                                                    _phoneNameController
                                                        .text.isNotEmpty) {
                                                  final contactData = {
                                                    _phoneNameController.text:
                                                        _phoneController.text
                                                  };
                                                  await firestore
                                                      .collection('users')
                                                      .doc(user.phoneNumber)
                                                      .collection('contacts')
                                                      .doc(selectedValue)
                                                      .set(contactData)
                                                      .then(
                                                        (value) =>
                                                            CoolAlert.show(
                                                          context: context,
                                                          type: CoolAlertType
                                                              .success,
                                                          text:
                                                              "Таны хүсэлт амжилттай !",
                                                        ),
                                                      );
                                                  setState(() {
                                                    selectedValue = '';
                                                  });
                                                  _phoneController.text = '';
                                                  _phoneNameController.text =
                                                      '';
                                                  Navigator.pop(context);
                                                } else {
                                                  CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.error,
                                                    text:
                                                        "Талбар хоосон байх ёсгүй !",
                                                  );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Colors.red.withOpacity(
                                                  0.75,
                                                ),
                                              ),
                                              child: Text(
                                                'Нэмэх',
                                                style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return Flexible(
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Text(
                                    document.id,
                                    style: GoogleFonts.rubik(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      buttonHide = !buttonHide;
                                    });
                                  },
                                  child: const Icon(Icons.arrow_drop_down),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: data.length * 75,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String key = data.keys.elementAt(index);

                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 60,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 7.5,
                                        ),
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  key,
                                                  style: GoogleFonts.rubik(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "${data[key]}",
                                                  style: GoogleFonts.rubik(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: Colors.red
                                                    .withOpacity(0.75),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
