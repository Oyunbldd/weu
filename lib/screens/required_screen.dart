import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../custom_widgets/stepper.dart' as CustomStepper;

class RequiredScreen extends StatefulWidget {
  const RequiredScreen({super.key});

  @override
  State<RequiredScreen> createState() => _RequiredScreenState();
}

class _RequiredScreenState extends State<RequiredScreen> {
  bool isButtonActive = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int currentStep = 0;

  final List<String> selectingTypes = [
    'Гэр бүлийн гишүүн',
    'Хамаатан садан',
    'Найз нөхөд',
  ];

  String selectedValue = '';

  String userUid = Get.arguments[0];
  String phoneNumber = Get.arguments[1];

  @override
  void initState() {
    super.initState();

    _phoneController.addListener(() {
      bool buttonType =
          _phoneController.text.length > 7 && selectedValue.isNotEmpty;
      setState(() {
        isButtonActive = buttonType;
      });
    });

    _usernameController.addListener(() {
      bool buttonType = _usernameController.text.isNotEmpty;
      setState(() {
        isButtonActive = buttonType;
      });
    });
  }

  Future<void> createUser({
    required String userName,
    required String userPhoneNumber,
    required String selectingType,
    required String requiredPhoneNumber,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = {
      'name': userName,
      'phoneNumber': userPhoneNumber,
      'contacts': {
        '$selectingType': requiredPhoneNumber,
      },
    };
    await firestore.collection('users').add(data);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('requiredScreen', false);
    LocationPermission permission = await Geolocator.checkPermission();
    if (LocationPermission.always == permission ||
        LocationPermission.whileInUse == permission) {
      return Get.toNamed('/mainScreen', arguments: ['allowed']);
    }
    if (LocationPermission.denied == permission) {
      return Get.toNamed('/mainScreen', arguments: ['denied']);
    }
  }

  List<CustomStepper.Step> getSteps() => [
        CustomStepper.Step(
          isActive: currentStep >= 0,
          title: const Text(''),
          content: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 300,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.withOpacity(0.25),
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Enable Location Access',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 25),
                const Text(
                  'lorem ipsum  lorem ipisum lorem ipsum',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  'lorem ipsum  lorem ip',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomStepper.Step(
          isActive: currentStep >= 1,
          title: const Text(''),
          content: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Миний нэрийг :',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.25, color: Colors.black),
                    ),
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Нэр",
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomStepper.Step(
          isActive: currentStep >= 2,
          title: const Text(''),
          content: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Яаралтай үед холбогдох',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'хүний дугаар :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 13),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      hint: const Text(
                        'Таны хэн болох ?',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: selectingTypes
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.25,
                          color: Colors.black,
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
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Theme(
          data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.red.withOpacity(0.75),
                  background: Colors.white,
                ),
          ),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              color: Colors.white,
              child: CustomStepper.Stepper(
                type: CustomStepper.StepperType.horizontal,
                steps: getSteps(),
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  return Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                isButtonActive
                                    ? Colors.red.withOpacity(0.75)
                                    : Colors.grey.withOpacity(0.25),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            onPressed: isButtonActive
                                ? () async {
                                    final isLastStep =
                                        currentStep == getSteps().length - 1;
                                    if (currentStep == 0) {
                                      await Geolocator.requestPermission();
                                      setState(() {
                                        currentStep = 1;
                                        isButtonActive = false;
                                      });
                                    } else if (!isLastStep) {
                                      setState(() {
                                        currentStep += 1;
                                        isButtonActive = false;
                                      });
                                    }
                                    if (isLastStep) {
                                      createUser(
                                        userName: _usernameController.text,
                                        userPhoneNumber: phoneNumber,
                                        selectingType: selectedValue,
                                        requiredPhoneNumber:
                                            _phoneController.text,
                                      );
                                    }
                                  }
                                : null,
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Үргэлжлүүлэх',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isButtonActive
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        currentStep > 0
                            ? SizedBox(
                                height: 45,
                                child: InkWell(
                                  onTap: () => setState(() {
                                    currentStep -= currentStep == 1 ? 0 : 1;
                                    isButtonActive = true;
                                  }),
                                  child: const SizedBox(
                                    child: Center(
                                      child: Text(
                                        'Буцах',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // onPressed: () {},
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
