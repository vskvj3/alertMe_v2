import 'package:alert_me/homepage.dart';
import 'package:alert_me/widgets/text_field.dart';
import 'package:alert_me/widgets/save_or_add_button.dart';
import "package:flutter/material.dart";

class LoginRegister extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 280.0,
        width: 300.0,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              phoneFormField(),
              // CustomTextField(
              //     labelText: 'Enter your phone number',
              //     controller: _phoneNumberController),
              const SizedBox(height: 20),
              CustomTextField(
                  labelText: 'Enter OTP', controller: _otpController),
              Visibility(
                visible: false,
                child: Row(children: [
                  const Text("Didn't get OTP?"),
                  TextButton(
                      onPressed: () => {},
                      child: const Text(
                        'send again',
                        style: TextStyle(),
                      ))
                ]),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomButton(text: 'Register', onPressed: () => {
                    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      )
    }
              })
            ],
          ),
        ),
      ),
    ));
  }

  TextFormField phoneFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        prefix: Text("+91 "),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.amber, width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: EdgeInsets.only(left: 20),
        filled: true,
        fillColor: Color(0xFFF9D1D1),
        labelText: "Phone",
        // floatingLabelBehavior: FloatingLabelBehavior.auto,
        // contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      controller: _phoneNumberController,
      validator: (value) {
        const pattern = r'[0-9]{10}';
        final regExp = RegExp(pattern);
        if (!regExp.hasMatch(value!)) return 'Enter Valid Phone Number';
        return null;
      },
      onFieldSubmitted: (value) => _formKey.currentState?.validate(),
    );
  }
}
