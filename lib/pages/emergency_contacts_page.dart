import 'package:alert_me/widgets/text_field.dart';
import 'package:alert_me/widgets/save_or_add_button.dart';
import 'package:flutter/material.dart';

class EmergencyContactsPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
        appBar: AppBar(
          backgroundColor:const Color.fromRGBO(170, 219, 253, 1),
          title: const Text('Emergency Contacts',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 20.0, top: 25.0, right: 20),
            child: ListView(
              children: [
                const Text(
                  'Edit Emergency Contacts',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 40.0),
                CustomTextField(
                    labelText: "Phone Number",
                    controller: _phoneNumberController),
                const SizedBox(height: 20.0),
                CustomTextField(labelText: "Name", controller: _nameController),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: 50.0,
                  height: 35.0,
                  child: Center(
                      child: CustomButton(
                          text: 'Add',
                          onPressed: () => {
                                //Add button functionality
                                debugPrint('Added')
                              })),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Your Emergency Contacts',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),

// only if any emergency contact is added

                const SizedBox(height: 40.0),
                Container(
                  height: 42.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF9D1D1),
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(children: [
                    const Text('Contact1',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                    const SizedBox(
                      width: 200.0,
                    ),
                    //   CustomButton(text: 'Remove', onPressed: ()=>{})

                    GestureDetector(
                      onTap: () {
                        debugPrint('Removed');
                      },
                      child: const Text(
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
