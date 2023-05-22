import 'package:abin_second_app/widgets/AlertListField.dart';
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(170, 219, 253, 1),
          title: Text('Alert Details',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 10.0, top: 25.0, right: 10),
            child: Container(
              padding: EdgeInsets.only(left: 10.0, top: 25.0, right: 10),
              height: 330.0,
              width: 390.0,
              decoration: BoxDecoration(
                  color: Color(0xFFF9D1D1),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                      child:Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Jane Doe',
                          style: TextStyle(fontSize: 18),
                        )),),
                        Align(
                          alignment: Alignment.centerRight,
                          child:Text('3s ago    ')
                        )
                    ]
                  ),
                  SizedBox(height: 20),
                  Text('Blood Group : O+'),
                  SizedBox(height: 20),
                  Text('Medical Info : '),
                  Text('Heart Patient, Diabetic'),
                  
                ],
              ),
            )));
  }
}
