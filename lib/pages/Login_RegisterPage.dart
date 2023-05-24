import 'package:abin_second_app/widgets/TextField.dart';
import 'package:abin_second_app/widgets/saveOrAddButton.dart';
import "package:flutter/material.dart";

class LoginRegister extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: Container(
        height: 280.0,
        width: 300.0,
        child: ListView(
          children: [
            CustomTextField(
                labelText: 'Enter your phone number',
                controller: _phoneNumberController),
            SizedBox(height: 20),
            CustomTextField(
                labelText: 'Enter OTP', controller: _phoneNumberController),
            Container(
              child: Row(children: [
                Text("Didn't get OTP?"),
                TextButton(
                    onPressed: () => {},
                    child: Text(
                      'send again',
                      style: TextStyle(),
                    ))
              ]),
            ),
            SizedBox(height: 20.0,),
            CustomButton(text: 'Register', onPressed: ()=>{})
          ],
        ),
      ),
    ));
  }
}
