import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(170, 219, 253, 1),
          title: Text('About',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Column(children: [
          Container(
            height: 200,
            padding: EdgeInsets.only(left: 20, top: 20.0),
            child: Row(children: [
              Image.asset(
                'assets/alert.png',
                height: 130,
                width: 130.0,
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                children: [
                  SizedBox(height: 38.0),
                  Text('AlertMe', style: TextStyle(fontSize: 23.0)),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Version : ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20.0),
                  Container(
                      child: Row(children: [
                    SizedBox(width: 13.0),
                    Text(
                      'Build Date :',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ]))
                ],
              )
            ]),
          ),
          Container(
              child: Column(
            children: [
              Container(
                height: 35.0,
                width: 400.0,
                padding: EdgeInsets.only(top: 20, left: 20.0),
                child: Text(
                  'You can report issues to our team via email :',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Container(
                height: 45.0,
                width: 400.0,
                padding: EdgeInsets.only(top: 20, left: 20.0),
                child: Text(
                  'alertme@gmail.com',
                  style: TextStyle(fontSize: 16.0, color: Colors.blue),
                ),
              ),
            ],
          ))
        ]));
  }
}
