import 'package:flutter/material.dart';

class RequiredScreen extends StatefulWidget {
  const RequiredScreen({super.key});

  @override
  State<RequiredScreen> createState() => _RequiredScreenState();
}

class _RequiredScreenState extends State<RequiredScreen> {
  int currentStep = 0;
  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Text(''),
          content: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 300,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Миний нэрийг :',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                TextField(),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text(''),
          content: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 300,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
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
                TextField(),
                TextField(),
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
                            Colors.red.withOpacity(0.75),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Үргэлжлүүлэх',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () => setState(() {
                          currentStep += 1;
                        }),
                      ),
                    ),
                    SizedBox(
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
                    ),
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
