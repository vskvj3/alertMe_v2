//widget for the recieved alert fields in the 'Alerts recievced' section

import 'package:abin_second_app/pages/AlertDetails.dart';
import 'package:flutter/material.dart';

class alertListField extends StatelessWidget {
  final String name;
  final String distance;
  final String nearFar;

  const alertListField(
      {required this.name, required this.distance, required this.nearFar});


  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () => {
          
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlertDetails(),
              ),
            )},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFF9D1D1)),
          height: 65,
          child: Row(
            children: [
              // Container(
              //   padding:EdgeInsets.only(left:20, top:10.0, right:30),
              //   child: Column(
              //     children: [
              //       Text(name,
              //       style:TextStyle(
              //         fontSize: 16.0
              //       )),
              //       SizedBox(height:10),
              //       Text(distance,

              //       style:TextStyle(
              //         backgroundColor: Colors.green,
              //         fontSize: 13.0
              //       ),),
              //     ],
              //   ),
              // ),
              // // SizedBox(width:210.0),
              // // Text(nearFar,
              // //       style:TextStyle(
              // //         fontSize: 15.0,
              // //         color: Colors.red
              // //       )),
              // Align(
              //   alignment: Alignment.,
              //   child:Text(nearFar,
              //       style:TextStyle(
              //         fontSize: 15.0,
              //         color: Colors.red
              //       )),
              // )

              Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 18.0, top: 13),
                        child: Column(
                          children: [
                            Text(
                              name,
                              style: TextStyle(fontSize: 15.0),
                            ),
                            SizedBox(height: 10),
                            Container(
                            child:Text(
                              distance,
                              style: TextStyle(fontSize: 11.0),
                            ),)
                          ],
                        ),
                      ))),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(nearFar,
                        style: TextStyle(fontSize: 13.0, color: Colors.red)),
                  ))
            ],
          ),
        ));
  }
}
