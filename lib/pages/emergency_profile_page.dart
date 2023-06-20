import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:alert_me/widgets/text_field.dart';
import 'package:alert_me/widgets/save_or_add_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

showSnakeBar(status, context) {
  var statusSnackBar = SnackBar(
    duration: const Duration(seconds: 1),
    content: Text(status),
  );
  ScaffoldMessenger.of(context).showSnackBar(statusSnackBar);
}

Future<Profile> fetchProfile() async {
  const storage = FlutterSecureStorage();
  String? phone = await storage.read(key: "phone");
  debugPrint('phone inside fetchProfile: $phone');
  final profileUrl = 'https://alertme.onrender.com/api/v1/profile/$phone';
  debugPrint('profile url: https://alertme.onrender.com/api/v1/profile/$phone');
  final response = await http.get(Uri.parse(profileUrl));
  debugPrint("return status code: ${response.statusCode}");

  if (response.statusCode == 201) {
    debugPrint('respose: ${response.body}');
    debugPrint(
        "profile from server: ${Profile.fromJson(jsonDecode(response.body))}");
    return Profile.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 403) {
    debugPrint("profile not found");
    throw Exception("profile not found");
  } else {
    throw Exception('Failed to load profile');
  }
}

Future<String> setProfile(name, dateOfBirth, bloodGroup, medicalDetails) async {
  try {
    const storage = FlutterSecureStorage();
    String? phone = await storage.read(key: "phone");

    final uri = Uri.parse('https://alertme.onrender.com/api/v1/profile');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'phone': phone,
      'name': name,
      'date_of_birth': dateOfBirth,
      'blood_group': bloodGroup,
      'medical_details': medicalDetails
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    debugPrint('response: ${response.body}');

    if (response.statusCode == 201) {
      debugPrint('profile update success');
      return "Profile Updated";
    } else {
      debugPrint('profile update failed');
      return "Error in updating profile";
    }
  } catch (err) {
    debugPrint('setProfile: ${err.toString()}');
    return err.toString();
  }
}

class Profile {
  final String phone;
  final String name;
  final String bloodGroup;
  final String dateOfBirth;
  final String medicalDetails;

  const Profile({
    required this.phone,
    required this.name,
    required this.bloodGroup,
    required this.dateOfBirth,
    required this.medicalDetails,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      phone: json['phone'],
      name: json['name'],
      bloodGroup: json['blood_group'],
      dateOfBirth: json['date_of_birth'],
      medicalDetails: json['medical_details'],
    );
  }
}

class EmergencyProfilePage extends StatefulWidget {
  const EmergencyProfilePage({super.key});

  @override
  State<EmergencyProfilePage> createState() => _EmergencyProfilePageState();
}

class _EmergencyProfilePageState extends State<EmergencyProfilePage> {
  late Future<Profile> futureProfile;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _medicalController = TextEditingController();
  final savedProfile = const SnackBar(
    content: Text('Profile saved success'),
  );

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
            title: const Text('Emergency Profile',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          body: FutureBuilder<Profile>(
            future: futureProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                debugPrint('inside snapshot.hasdata');
                debugPrint('data: ${snapshot.data}');
                _nameController.text = snapshot.data!.name;
                _dateController.text = snapshot.data!.dateOfBirth;
                _bloodGroupController.text = snapshot.data!.bloodGroup;
                _medicalController.text = snapshot.data!.medicalDetails;

                return ProfileForm(
                    nameController: _nameController,
                    dateController: _dateController,
                    bloodGroupController: _bloodGroupController,
                    medicalController: _medicalController);
              } else if (snapshot.hasError) {
                debugPrint("inside snapshot.hasError");
                debugPrint('error: ${snapshot.error}');
                if ('${snapshot.error}' ==
                    "Failed host lookup: 'alertme.onrender.com'") {
                  return const Center(
                    child: Text("no net connection"),
                  );
                } else {
                  return ProfileForm(
                      nameController: _nameController,
                      dateController: _dateController,
                      bloodGroupController: _bloodGroupController,
                      medicalController: _medicalController);
                }
              }

              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    super.key,
    required TextEditingController nameController,
    required TextEditingController dateController,
    required TextEditingController bloodGroupController,
    required TextEditingController medicalController,
  })  : _nameController = nameController,
        _dateController = dateController,
        _bloodGroupController = bloodGroupController,
        _medicalController = medicalController;

  final TextEditingController _nameController;
  final TextEditingController _dateController;
  final TextEditingController _bloodGroupController;
  final TextEditingController _medicalController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          const Text(
            'Personal Information',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30.0),
          CustomTextField(labelText: "Name", controller: _nameController),
          const SizedBox(height: 20.0),
          CustomTextField(
              labelText: "Date of birth", controller: _dateController),
          const SizedBox(height: 10.0),
          const SizedBox(height: 40.0),
          const Text(
            'Medical Information',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          CustomTextField(
              labelText: 'Blood Group', controller: _bloodGroupController),
          const SizedBox(height: 20),
          CustomTextField(
              labelText: 'Medical Conditions or allergies if any',
              controller: _medicalController),
          const SizedBox(height: 30.0),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.only(right: 50, left: 50),
            width: 70.0,
            height: 35.0,
            child: Center(
                child: CustomButton(
              text: 'Save Profile',
              onPressed: () async {
                String saveStatus = await setProfile(
                  _nameController.text,
                  _dateController.text,
                  _bloodGroupController.text,
                  _medicalController.text,
                );
                if (context.mounted) showSnakeBar(saveStatus, context);
              },
            )),
          ),
        ]),
      ),
    );
  }
}
