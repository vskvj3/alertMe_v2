import 'package:flutter/material.dart';


class AlertDetails extends StatelessWidget {
  const AlertDetails({super.key});

  // final String name;
  // final String bloodGroup;
  // final String medicalInfo;

  // const AlertDetails({
  //   required this.name,
  //   required this.bloodGroup,
  //   required this.medicalInfo
  // });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text(
            'Alert Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 10.0, top: 30, right: 10.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0, right: 10),
                  height: 350.0,
                  width: 390.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Jane Doe',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('3s ago    '),
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      const Text('Blood Group : O+'),
                      const SizedBox(height: 30.0),
                      const Text('Medical Info : '),
                      const SizedBox(height: 10.0),
                      const Text('Heart Patient, Diabetic'),
                      const SizedBox(height: 35.0),
                      ElevatedButton(
                        onPressed: () => {debugPrint("[Pressed] view on map")},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          fixedSize: const Size(10, 50),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: const Text('View on map'),
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        "   5 people flagged false",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 390,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => {debugPrint("[pressed] contact")},
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                      ),
                      child: const Text("contact"),
                    ),
                    ElevatedButton(
                      onPressed: () => {debugPrint("[pressed] flag as false")},
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.redAccent,
                        padding:const  EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                      ),
                      child: const Text("flag as false"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
