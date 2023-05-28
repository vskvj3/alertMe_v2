import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text ;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF9D1D1), // Set the button color
      ),
      child:  Text(
        text,
        style:  const TextStyle(color: Colors.black),
      ),
    );
  }
}
