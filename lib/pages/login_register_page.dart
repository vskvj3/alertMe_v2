import 'package:alert_me/homepage.dart';
import 'package:alert_me/widgets/text_field.dart';
import 'package:alert_me/widgets/save_or_add_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _verificationCode;
  final snackBar = const SnackBar(
    content: Text('Wrong OTP'),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 300.0,
          width: 300.0,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefix: Text("+91 "),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.amber,
                          width: 0,
                          style: BorderStyle.none),
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
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    const pattern = r'[0-9]{10}';
                    final regExp = RegExp(pattern);
                    if (!regExp.hasMatch(value!))
                      return 'Enter Valid Phone Number';
                    return null;
                  },
                  onFieldSubmitted: (value) =>
                      _formKey.currentState?.validate(),
                ),
                const SizedBox(height: 20),
                CustomButton(text: 'send OTP', onPressed: verifyOTP),
                const SizedBox(height: 40),
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
                          style: TextStyle(color: Colors.black),
                        ))
                  ]),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomButton(
                    text: 'Register',
                    onPressed: () {
                      try {
                        FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode,
                                smsCode: _otpController.text))
                            .then((value) async {
                          if (value.user != null) {
                            debugPrint("user logged in....");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false);
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }

  void verifyOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91 ${_phoneNumberController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // try {
        //   await FirebaseAuth.instance
        //       .signInWithCredential(credential)
        //       .then((value) async {
        //     if (value.user != null) {
        //       debugPrint(
        //           "user loggen in .........................................................");
        //       Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(builder: (context) => HomePage()),
        //           (route) => false);
        //     }
        //   });
        // } catch (e) {
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
