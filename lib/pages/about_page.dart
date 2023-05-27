import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text('About',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.only(left: 20, top: 20.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/alert.png',
                    height: 130,
                    width: 130.0,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  const Column(
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
                      Row(
                        children: [
                          SizedBox(width: 13.0),
                          Text(
                            'Build Date :',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You can report issues to our team via email :',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.justify,
                ),
                Text('alertme@gmail.com',
                    style: TextStyle(fontSize: 16.0, color: Colors.blue)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
