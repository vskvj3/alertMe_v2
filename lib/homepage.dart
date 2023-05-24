
import 'package:abin_second_app/pages/EmergencyProfilePage.dart';
import 'package:abin_second_app/pages/alertsNearPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:abin_second_app/widgets/alertViewButton.dart';
import 'package:abin_second_app/pages/AboutPage.dart';
import 'package:abin_second_app/pages/FAQpage.dart';
import 'package:abin_second_app/pages/EmergencyContactsPage.dart';
import 'package:abin_second_app/pages/SettingsPage.dart';



class HomePage extends StatelessWidget {

  Widget verticalDivider=VerticalDivider(
    thickness: 1,
    color:Colors.grey
  );



  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(

      //navbar 
      
      appBar: AppBar(
        
        backgroundColor: Color.fromRGBO(170, 219, 253, 1),
          title: Text('AlertMe',style: 
          TextStyle(color:Colors.black,
          fontWeight: FontWeight.bold)),
          
          
          actions: [
            PopupMenuButton<String>(
              color:Color.fromRGBO(170, 219, 253, 1),
              onSelected: (String choice) {
                // Handle menu item selection

                if (choice == 'Settings') {
                  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
                  print('Settings Page');
                } 
                
                
                else if (choice == 'Emergency Profile') {
                  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmergencyProfilePage(),
              ),
            );
                  print('Emergency Profile Page');
                }


                 else if (choice == 'Emergency Contacts') {
                  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmergencyContactsPage(),
              ),
            );
                  print('Emergency Contacts Page');
                 }
                
                
                else if (choice == 'FAQ') {
                  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FAQPage(),
              ),
            );
                  print('FAQ Page');
                }
                
                
                else if (choice == 'About') {
                  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutPage(),
              ),
            );
                  print('About Page');
                }
                
                
                else if (choice == 'Quit') {
                   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  print('Quit');
                }
              },


              itemBuilder: (BuildContext context) {
                
                return [
                  PopupMenuItem<String>(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                  PopupMenuDivider(height:20),
                  PopupMenuItem<String>(
                    value: 'Emergency Profile',
                    child: Text('Emergency Profile'),
                  ),
                  PopupMenuDivider(height:20),
                  PopupMenuItem<String>(
                    value: 'Emergency Contacts',
                    child: Text('Emergency Contacts'),
                  ),
                  PopupMenuDivider(height:20),
                  PopupMenuItem<String>(
                    value: 'FAQ',
                    child: Text('FAQ'),
                  ),
                  PopupMenuDivider(height:20),
                  PopupMenuItem<String>(
                    value: 'About',
                    child: Text('About'),
                  ),
                  PopupMenuDivider(height:20),
                  PopupMenuItem<String>(
                    value: 'Quit',
                    child: Text('Quit'),
                  ),
                ];
              },
            ),
          ],

          
        ),



// body of home page



      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height:110.0,
          ),



          Container(
            color:Colors.white,
            height:293.0,
            padding: EdgeInsets.only(),
            alignment: Alignment.center,
            child: ElevatedButton(   
                      
              onPressed: () {
                print("ALERT!!");
                // Handle panic button press event
              },
              child: Text(
                'ALERT',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(

                
                shape: MaterialStateProperty.all<CircleBorder>(
                  CircleBorder(),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(120),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.red,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                overlayColor: MaterialStateProperty.all<Color>(
                  Colors.red[800]!,
                ),
                elevation: MaterialStateProperty.all<double>(10.0),
                shadowColor: MaterialStateProperty.all<Color>(
                  Colors.red[800]!,
                ),
                animationDuration: Duration(milliseconds: 200),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          
        ],
        
      ),
      bottomNavigationBar: BottomAppBar(
        child:Container(
          height:75,
          color: Color(0xFFAADBFD),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              alertViewButton('Alert', 
              (){
                  // what happens when the alert button is clicked
                  Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false, // Prevent navigating back
            );
                }, 
                 Colors.red,
                 FontWeight.w400),

              // Text(
              //   'Alert',
              //   style: TextStyle(
              //     fontSize: 28.0,
              //     fontWeight: FontWeight.w300,
              //     color: Colors.red,
              //   ),
              // ),
              verticalDivider,
              // Text(
              //   'View',
              //   style: TextStyle(
              //     fontSize: 28.0,
              //     fontWeight: FontWeight.w300,
              //     color: Colors.black,
              //   ),
              // ),
              alertViewButton('View',
              (){
                  Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AlertsNear(),
              ),
              (route) => false, // Prevent navigating back
            );
                  print('Alert View Page');
                }, 
                 Colors.black,
                 FontWeight.w400),
            ],
          ),
        ),
        

      ),
    
    ));
  }
}
