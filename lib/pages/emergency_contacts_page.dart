import 'dart:convert';
import 'package:alert_me/utils/validate_data.dart';
import 'package:alert_me/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../utils/emergency_contact_storage.dart';
import '../widgets/save_or_add_button.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  List<List<String>> emergencyContactList = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final dynamic temp =
        jsonDecode(await EmergencyDataStorage.readAllContacts() ?? "[]");

    if (temp != "[]") {
      for (var item in temp) {
        if (item is List<dynamic>) {
          emergencyContactList.add(List<String>.from(item));
        }
      }
      setState(() {
        emergencyContactList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text(
            'Emergency Contacts',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 25.0, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Edit Emergency Contacts',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 40.0),
                    CustomTextField(
                        labelText: "Name", controller: _nameController),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      prefixtext: "+91 ",
                      labelText: "Phone Number",
                      controller: _phoneNumberController,
                    ),
                    const SizedBox(height: 30.0),
                    Center(
                      child: SizedBox(
                        width: 120.0,
                        height: 35.0,
                        child: CustomButton(
                          text: 'Add',
                          onPressed: () async {
                            // Add button functionality

                            if (_nameController.text.isNotEmpty &&
                                _phoneNumberController.text.isNotEmpty &&
                                emergencyContactList.length < 5 &&
                                PhoneValidator.validatePhoneNumber(
                                    _phoneNumberController.text) && !(PhoneValidator.checkDuplicate(emergencyContactList,_phoneNumberController.text))) {
                              final tempList = [
                                _nameController.text,
                                _phoneNumberController.text
                              ];
                              emergencyContactList.add(tempList);
                              await EmergencyDataStorage.storeContacts(
                                  json.encode(emergencyContactList));
                              emergencyContactList = [];
                              final dynamic temp = jsonDecode(
                                  await EmergencyDataStorage
                                          .readAllContacts() ??
                                      "[]");
                              if (temp != "") {
                                for (var item in temp) {
                                  if (item is List<dynamic>) {
                                    emergencyContactList
                                        .add(List<String>.from(item));
                                  }
                                }
                                setState(() {
                                  _phoneNumberController.text ="";
                                  _nameController.text="";
                                  emergencyContactList;
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "Emergency Contact List :",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              if (emergencyContactList.isEmpty) ...[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "No Emergency contacts currently entered",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ] else ...[
                Container(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 25.0, right: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: emergencyContactList.length,
                    itemBuilder: (BuildContext context, int index) => Card(
                      color: const Color(0xFFF9D1D1),
                      child: ListTile(
                        trailing: TextButton(
                            onPressed: () async {
                              setState(() {
                              emergencyContactList.removeAt(index);
                            });
                            await EmergencyDataStorage.storeContacts(
                              json.encode(emergencyContactList),
                            );
                            },
                            child: const Text("Remove")),
                        contentPadding: const EdgeInsets.only(left: 10),
                        title: Text(
                          emergencyContactList[index][0],
                          key: Key('title_row_$index'),
                        ),
                        subtitle: Text(
                          emergencyContactList[index][1],
                          key: Key('subtitle_row_$index'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
