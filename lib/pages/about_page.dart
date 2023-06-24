import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
                  title: const Text('About',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 38.0),
                              const Text('AlertMe',
                                  style: TextStyle(
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Version : ${snapshot.data?.version}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Row(
                                children: [
                                  const SizedBox(width: 0),
                                  Text(
                                    'Build Number : ${snapshot.data?.buildNumber}',
                                    style: const TextStyle(
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
                        Text('alertme.team@gmail.com',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue)),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Text("Error");
          }
        });
  }
}
