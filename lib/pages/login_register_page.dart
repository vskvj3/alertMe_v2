import 'package:alert_me/widgets/text_field.dart';
import 'package:alert_me/widgets/save_or_add_button.dart';
import "package:flutter/material.dart";

class LoginRegister extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  LoginRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 280.0,
        width: 300.0,
        child: ListView(
          children: [
            CustomTextField(
                labelText: 'Enter your phone number',
                controller: _phoneNumberController),
            const SizedBox(height: 20),
            CustomTextField(
                labelText: 'Enter OTP', controller: _otpController),
            Row(children: [
              const Text("Didn't get OTP?"),
              TextButton(
                  onPressed: () => {},
                  child: const Text(
                    'send again',
                    style: TextStyle(),
                  ))
            ]),
            const SizedBox(height: 20.0,),
            CustomButton(text: 'Register', onPressed: ()=>{})
          ],
        ),
      ),
    ));
  }
}
