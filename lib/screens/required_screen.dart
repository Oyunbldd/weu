import 'package:flutter/material.dart';

class RequiredScreen extends StatefulWidget {
  const RequiredScreen({super.key});

  @override
  State<RequiredScreen> createState() => _RequiredScreenState();
}

class _RequiredScreenState extends State<RequiredScreen> {
  bool isButtonActive = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  int currentStep = 0;

  @override
  void initState() {
    super.initState();

    _phoneController.addListener(() {
      bool buttonType =
          _phoneController.text.length > 7 && _nameController.text.isNotEmpty;
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

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
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
        Step(
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Нэр",
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
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
                          fontSize: 12,
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
        Step(
          isActive: currentStep >= 2,
          title: const Text(''),
          content: Container(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stepper(
            type: StepperType.horizontal,
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        onPressed: isButtonActive
                            ? () {
                                final isLastStep =
                                    currentStep == getSteps().length - 1;
                                if (!isLastStep) {
                                  setState(() {
                                    currentStep += 1;
                                    isButtonActive = false;
                                  });
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
                                color:
                                    isButtonActive ? Colors.white : Colors.grey,
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
                                currentStep -= 1;
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
    );
  }
}
