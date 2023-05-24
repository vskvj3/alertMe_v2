import 'package:abin_second_app/widgets/AlertListField.dart';
import 'package:abin_second_app/widgets/saveOrAddButton.dart';
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
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView(
                    children: [
                      Row(children: [
                        Expanded(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Jane Doe',
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text('3s ago    '))
                      ]),
                      SizedBox(height: 30.0),
                      Text('Blood Group : O+'),
                      SizedBox(height: 30.0),
                      Text('Medical Info : '),
                      SizedBox(height: 10.0),
                      Text('Heart Patient, Diabetic'),
                      SizedBox(height: 35.0),
                      TextButton(
                          // color:Colors.green,
                          onPressed: () => {},
                          child: Container(
                            width: 350.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Color(0xFF7C7C7C),
                                borderRadius:
                                    BorderRadiusDirectional.circular(10.0)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'View on map',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(height: 35),
                      Text(
                        "   5 people flagged false",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.only(left:30.0),
              child: Row(
                children: [
                  Container(
                    width: 180.0,
                    decoration: BoxDecoration(
                      color:Color(0xFF398200),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:TextButton(onPressed: ()=>{}, 
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Contact',
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 15.0,
                    ),),
                  ))),
                  SizedBox(width: 30.0,),
                  Container(
                    width: 130.0,
                    decoration: BoxDecoration(
                      color:Color(0xFF780000),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:TextButton(onPressed: ()=>{}, 
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Flag as false',
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 15.0,
                    ),),
                  ))),
                ],
              ),
              )
          ],
        )));
  }
}
