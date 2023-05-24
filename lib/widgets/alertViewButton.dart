import "package:flutter/material.dart";

Widget alertViewButton(String buttonText, void Function() buttonAction,
    Color buttonColor, FontWeight buttonFontWeight) {
  return TextButton(
    onPressed: buttonAction,
    child: Text(buttonText,
        style: TextStyle(
          color: buttonColor,
          fontSize: 28,
        )),
  );
}
