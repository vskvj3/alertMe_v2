import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:abin_second_app/widgets/TextField.dart';
import 'package:flutter/rendering.dart';
import 'package:abin_second_app/widgets/saveOrAddButton.dart';

class EmergencyProfilePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _medicalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(170, 219, 253, 1),
              title: Text('Emergency Profile',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            body: Container(
                padding: EdgeInsets.only(top: 16.0, left: 8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(children: [
                    Text(
                      'Personal Information',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 30.0),
                    CustomTextField(
                        labelText: "Name", controller: _nameController),
                    SizedBox(height: 20.0),
                    CustomTextField(
                        labelText: "Date of birth",
                        controller: _dateController),
                    SizedBox(height: 30.0),
                    Container(
                      child: Center(
                          child: CustomButton(
                              text: 'Save',
                              onPressed: () => {
                                    //Add button functionality
                                    print('Saved personal information')
                                  })),
                      width: 50.0,
                      height: 35.0,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Medical Information',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                        labelText: 'Blood Group',
                        controller: _bloodGroupController),
                    SizedBox(height: 20),
                    CustomTextField(
                        labelText: 'Medical Conditions or allergies if any',
                        controller: _medicalController),
                    SizedBox(height: 30.0),
                    Container(
                      child: Center(
                          child: CustomButton(
                              text: 'Save',
                              onPressed: () => {
                                    //Add button functionality
                                    print('Saved medical information')
                                  })),
                      width: 50.0,
                      height: 35.0,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.only(right: 50, left: 50),
                      child: Center(
                          child: CustomButton(
                        text: 'Save Profile',
                        onPressed: () => {
                          //Add button functionality
                          print('Saved Profile')
                        },
                      )),
                      width: 70.0,
                      height: 35.0,
                    ),
                  ]),
                ))));
  }
}
