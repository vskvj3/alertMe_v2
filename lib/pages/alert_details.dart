import 'dart:convert';

import 'package:alert_me/utils/alert_functions.dart';
import 'package:alert_me/utils/alert_receiver.dart';
import 'package:flutter/material.dart';


class AlertDetails extends StatefulWidget {
  final AlertData alertDetails;
  const AlertDetails({super.key,required this.alertDetails});
  @override
  State<AlertDetails> createState() => _AlertDetailsState();
}

class _AlertDetailsState extends State<AlertDetails> {
  
  ProfileData profileData = ProfileData("", "", "", "", "", "", "", 0, 0);

  
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    profileData = await AlertReceiver.fetchProfileData(widget.alertDetails.id);
    setState(() {
      profileData;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return 

SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text(
            'Alert Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 10.0, top: 30, right: 10.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0, right: 10),
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
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text('3s ago    '),
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Text('Blood Group : ${profileData.bloodGroup}'),
                      const SizedBox(height: 30.0),
                      const Text('Medical Info : '),
                      const SizedBox(height: 10.0),
                      Text(profileData.medicalDetails),
                      const SizedBox(height: 35.0),
                      ElevatedButton(
                        onPressed: () => {debugPrint("[Pressed] view on map")},
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
                        style:const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 35),
                      Text(
                        "   ${profileData.viewCount} people viewed this alert",
                        style:const TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 390,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => {debugPrint("[pressed] contact")},
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
                        profileData.flagCount = profileData.flagCount+1;
                        final response = await AlertFunctions.updateCount(widget.alertDetails.id);
                        if(response.statusCode == 200){
                          final responseData = json.decode(response.body);
                          profileData.flagCount = responseData['flag_count'];

                        }else{throw Exception("can't update flagcount");} 
                        setState((){
                          profileData;
                        });
                        
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.redAccent,
                        padding:const  EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                      ),
                      child: const Text("flag as false"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

