import 'dart:convert';

import 'package:alert_me/utils/alert_functions.dart';
import 'package:alert_me/utils/alert_receiver.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertDetails extends StatefulWidget {
  final AlertData alertDetails;

  const AlertDetails({Key? key, required this.alertDetails}) : super(key: key);

  @override
  State<AlertDetails> createState() => _AlertDetailsState();
}

class _AlertDetailsState extends State<AlertDetails> {
  late Future<ProfileData> profileDataFuture;

  @override
  void initState() {
    super.initState();
    profileDataFuture = AlertReceiver.fetchProfileData(widget.alertDetails.id);
  }

  String timeDiff() {
    String currentTimeString = DateFormat('hh:mm:ss').format(DateTime.now());
    DateTime currentTime = DateTime.parse('2000-01-01 $currentTimeString');
    DateTime alertTime =
        DateTime.parse('2000-01-01 ${widget.alertDetails.time}');

    Duration difference = currentTime.difference(alertTime);

    if (difference.inHours < 1) {
      return "${difference.inMinutes.remainder(60)}m ago";
    } else {
      return "${difference.inHours}h ${difference.inMinutes.remainder(60)}m ago";
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await canLaunch(url)) {
      throw Exception('Could not launch $url');
    }
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text(
            'Alert Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<ProfileData>(
          future: profileDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading profile data'));
            } else {
              final profileData = snapshot.data!;
              return Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 30, right: 10.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 25.0, right: 10),
                      height: 430.0,
                      width: 390.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9D1D1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.alertDetails.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(timeDiff()),
                              )
                            ],
                          ),
                          const SizedBox(height: 30.0),
                          Text('Blood Group: ${profileData.bloodGroup}'),
                          const SizedBox(height: 30.0),
                          const Text('Medical Info: '),
                          const SizedBox(height: 10.0),
                          Text(profileData.medicalDetails),
                          const SizedBox(height: 35.0),
                          ElevatedButton(
                            onPressed: () async {
                              final List<dynamic> locations =
                                  json.decode(widget.alertDetails.location);

                              String encodedLatitude =
                                  Uri.encodeComponent(locations[0].toString());
                              String encodedLongitude =
                                  Uri.encodeComponent(locations[1].toString());
                              String encodedComma = Uri.encodeComponent(",");
                              String mapUrl =
                                  "https://maps.google.com/maps?q=$encodedLatitude$encodedComma$encodedLongitude";
                              await _launchUrl(mapUrl);

                              debugPrint("[Pressed] view on map");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              fixedSize: const Size(10, 50),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            child: const Text('View on map'),
                          ),
                          const SizedBox(height: 35),
                          Text(
                            "   ${profileData.flagCount} people flagged false",
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 35),
                          Text(
                            "   ${profileData.viewCount} people viewed this alert",
                            style: const TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 390,
                      child: ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              debugPrint(profileData.phone);
                              _launchUrl('tel://${profileData.phone}');
                              debugPrint("[pressed] contact");
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                            ),
                            child: const Text("contact"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              profileData.flagCount = profileData.flagCount + 1;
                              final response = await AlertFunctions.updateCount(
                                  widget.alertDetails.id);
                              if (response.statusCode == 200) {
                                final responseData = json.decode(response.body);
                                profileData.flagCount =
                                    responseData['flag_count'];
                              } else {
                                throw Exception("can't update flagcount");
                              }
                              setState(() {
                                profileData;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                            ),
                            child: const Text("flag as false"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
