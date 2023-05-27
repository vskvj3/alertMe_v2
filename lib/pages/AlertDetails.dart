import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AlertDetails extends StatelessWidget {
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
          backgroundColor: Color.fromRGBO(170, 219, 253, 1),
          title: Text(
            'Alert Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 10.0, top: 30, right: 10.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, top: 25.0, right: 10),
                    height: 350.0,
                    width: 390.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9D1D1),
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
                        SizedBox(height: 30.0),
                        Text('Blood Group : O+'),
                        SizedBox(height: 30.0),
                        Text('Medical Info : '),
                        SizedBox(height: 10.0),
                        Text('Heart Patient, Diabetic'),
                        SizedBox(height: 35.0),
                        ElevatedButton(
                          onPressed: () => {print("[Pressed] view on map")},
                          child: Text('View on map'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            fixedSize: Size(10, 50),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 35),
                        Text(
                          "   5 people flagged false",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  )),
              SizedBox(height: 30),
              Center(
                child: Container(
                  width: 390,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => {print("[pressed] contact")},
                        child: Text("contact"),
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {print("[pressed] flag as false")},
                        child: Text("flag as false"),
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                        ),
                      ),
                    ],
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
