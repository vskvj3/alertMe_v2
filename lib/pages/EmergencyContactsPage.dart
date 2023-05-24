import 'package:abin_second_app/widgets/TextField.dart';
import 'package:abin_second_app/widgets/saveOrAddButton.dart';
import 'package:flutter/material.dart';

class EmergencyContactsPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(170, 219, 253, 1),
          title: Text('Emergency Contacts',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20),
            child: ListView(
              children: [
                Text(
                  'Edit Emergency Contacts',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 40.0),
                CustomTextField(
                    labelText: "Phone Number",
                    controller: _phoneNumberController),
                SizedBox(height: 20.0),
                CustomTextField(labelText: "Name", controller: _nameController),
                SizedBox(height: 30.0),
                Container(
                  child: Center(
                      child: CustomButton(
                          text: 'Add',
                          onPressed: () => {
                                //Add button functionality
                                print('Added')
                              })),
                  width: 50.0,
                  height: 35.0,
                ),
                SizedBox(height: 50),
                Text(
                  'Your Emergency Contacts',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),

// only if any emergency contact is added

                SizedBox(height: 40.0),
                Container(
                  height: 42.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      color: Color(0xFFF9D1D1),
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: EdgeInsets.only(left: 20),
                  child: Row(children: [
                    Text('Contact1',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                    SizedBox(
                      width: 220.0,
                    ),
                    //   CustomButton(text: 'Remove', onPressed: ()=>{})

                    GestureDetector(
                      onTap: () {
                        print('Removed');
                      },
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          // decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ))));
  }
}
