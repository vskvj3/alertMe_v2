import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
              title: const Text('FAQ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            body: Container(
              padding: const EdgeInsets.only(left: 20.0, top: 25.0, right: 20),
              child: ListView(
                children: [
                  const Text(
                    'How does the app work?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.only(top: 25.0, left: 17.0, right: 17),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF9D1D1),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 175.0,
                    child: const Text(
                      'When a user presses the panic button, the app sends out an alert to their emergency contacts and nearby app users, along with their real-time location. This allows those users to quickly respond and provide assistance.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Is the app free to use?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.only(top: 25.0, left: 17.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF9D1D1),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 150.0,
                    child: const Text(
                      'Yes, the app is completely free to download and use.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
