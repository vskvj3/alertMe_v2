import 'package:alert_me/homepage.dart';
import 'package:alert_me/pages/emergency_profile_page.dart';
import 'package:alert_me/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:alert_me/utils/register_user.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _otpscreenvisibility = false;
  dynamic _verificationCode;
  var _isSendOTPPressed = false;
  var _isVerifyPressed = false;
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
            child: Column(
              children: [
                Visibility(
                  visible: !_otpscreenvisibility,
                  child: phoneNumberScreen(),
                ),
                Visibility(
                  visible: _otpscreenvisibility,
                  child: otpScreen(context),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Column otpScreen(BuildContext context) {
    return Column(
      children: [
        CustomTextField(labelText: 'Enter OTP', controller: _otpController),
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
        ElevatedButton(
          onPressed: !_isVerifyPressed
              ? () async {
                  setState(() {
                    _isVerifyPressed = true;
                  });
                  try {
                    FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode,
                            smsCode: _otpController.text))
                        .then((value) async {
                      if (value.user != null) {
                        var response = registerUser(
                            value.user!.phoneNumber, value.user!.uid);
                        debugPrint("response: $response");

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EmergencyProfilePage()),
                            (route) => false);
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              : null,
          child: const Text('Register'),
        ),
        loadingIndicator(_isVerifyPressed)
      ],
    );
  }

  Widget phoneNumberScreen() {
    return Column(
      children: [
        PhoneTextField(
            phoneNumberController: _phoneNumberController, formKey: _formKey),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: !_isSendOTPPressed
              ? () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isSendOTPPressed = true;
                    });
                    verifyOTP();
                  }
                }
              : null,
          child: const Text('send OTP'),
        ),
        loadingIndicator(_isSendOTPPressed)
      ],
    );
  }

  Widget loadingIndicator(check) {
    if (check == true) {
      return const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  void verifyOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91 ${_phoneNumberController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              debugPrint('creadential: $credential');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            }
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint(e.message);
        const snackBar = SnackBar(
          content: Text('Cannot send otp, check number'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _otpscreenvisibility = true;
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    required TextEditingController phoneNumberController,
    required GlobalKey<FormState> formKey,
  })  : _phoneNumberController = phoneNumberController,
        _formKey = formKey;

  final TextEditingController _phoneNumberController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
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
        if (!regExp.hasMatch(value!)) return 'Enter Valid Phone Number';
        return null;
      },
      onFieldSubmitted: (value) => _formKey.currentState?.validate(),
    );
  }
}
