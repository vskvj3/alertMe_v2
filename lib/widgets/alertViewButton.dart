import "package:flutter/material.dart";

Widget alertViewButton(String buttonText, void Function() buttonAction,
    Color buttonColor, FontWeight buttonFontWeight) {
  return FlatButton(
    onPressed: buttonAction,
    child: Text(buttonText,
        style: TextStyle(
          color: buttonColor,
          fontSize: 28,
        )),
    padding: EdgeInsets.only(top: 18, bottom: 20),
  );
}
