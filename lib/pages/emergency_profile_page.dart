import 'package:flutter/material.dart';
import 'package:alert_me/widgets/text_field.dart';
import 'package:alert_me/widgets/save_or_add_button.dart';

class EmergencyProfilePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _medicalController = TextEditingController();

  EmergencyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text('Emergency Profile',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30.0),
              CustomTextField(labelText: "Name", controller: _nameController),
              const SizedBox(height: 20.0),
              CustomTextField(
                  labelText: "Date of birth", controller: _dateController),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 50.0,
                height: 35.0,
                child: Center(
                  child: CustomButton(
                    text: 'Save',
                    onPressed: () => {
                      //Add button functionality
                      debugPrint('Saved personal information')
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Medical Information',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                  labelText: 'Blood Group', controller: _bloodGroupController),
              const SizedBox(height: 20),
              CustomTextField(
                  labelText: 'Medical Conditions or allergies if any',
                  controller: _medicalController),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 50.0,
                height: 35.0,
                child: Center(
                  child: CustomButton(
                    text: 'Save',
                    onPressed: () => {
                      //Add button functionality
                      debugPrint('Saved medical information')
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(right: 50, left: 50),
                width: 70.0,
                height: 35.0,
                child: Center(
                    child: CustomButton(
                  text: 'Save Profile',
                  onPressed: () => {
                    //Add button functionality
                    debugPrint('Saved Profile')
                  },
                )),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
