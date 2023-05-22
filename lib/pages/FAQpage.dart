import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(170, 219, 253, 1),
          title: Text('FAQ',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20),
          child: ListView(
            children: [
              Text(
                'How does the app work?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 17.0, right: 17),
                decoration: BoxDecoration(
                    color: Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10.0)),
                height: 150.0,
                child: Text(
                  'When a user presses the panic button, the app sends out an alert to their emergency contacts and nearby app users, along with their real-time location. This allows those users to quickly respond and provide assistance.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Is the app free to use?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 17.0),
                decoration: BoxDecoration(
                    color: Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10.0)),
                height: 150.0,
                child: Text(
                  'Yes, the app is completely free to download and use.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
