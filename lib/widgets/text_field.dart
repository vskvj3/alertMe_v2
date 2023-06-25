
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final String? prefixtext;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.prefixtext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: const Color(0xFFF9D1D1)),
        height: 42.0,
        width: 380.0,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              prefix: Text(prefixtext??"",style: const TextStyle(
                fontWeight: FontWeight.w400),),
              labelText: labelText,
              // floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none),
        ));
  }
}
