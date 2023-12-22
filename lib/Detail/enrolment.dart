import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pb_apps/api_url/api_url.dart';
import 'package:pb_apps/widget/Big_text.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';
import 'package:http/http.dart' as http;
import '../models/state_model.dart';
class Enrolment extends StatefulWidget {
  const Enrolment({Key? key}) : super(key: key);
  @override
  State<Enrolment> createState() => _EnrolmentState();
}
class _EnrolmentState extends State<Enrolment> {
  static  FlutterSecureStorage storage = const FlutterSecureStorage();
  List<States> states = [];
  int? selectedStateId;
  //admin.type
  List<String> configValues = [];
  String? selectedConfigValue;
  @override
  void initState() {
    super.initState();
    fetchStates();
    fetchConfigData();
  }
  // upload image code
  final picker = ImagePicker();
  String imageName = '';
  int mediaId = 0;
  int maxImageSizeInBytes = 5 * 1024 * 1024; // 5 MB
  Future<void> getImageFromGallery() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    setState(() {
      imageName = 'Uploading...';
    }
    );
    final Uint8List imageBytes = await pickedFile.readAsBytes();
    if (imageBytes.length > maxImageSizeInBytes) {
      setState(() {
        imageName = 'Image size is too large';
      });
      return;
    }
    String base64Image = base64Encode(imageBytes);
    final Map<String, dynamic> payload = {
      "fileType": pickedFile.mimeType,
      "base64Image": base64Image,
      "name": pickedFile.name,
      "categoryName": "users",
    };
    try {
      final String? value = await storage.read(key: 'token');
      final http.Response response = await http.post(
        Uri.parse('${Constants.BASE_URL}/api/v1/media'),
        headers: {
          'Authorization': value.toString(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        imageName = responseData['name'];
        mediaId = responseData['id'];
        setState(() {
          imageName = 'Image uploaded successfully';
        });
      } else {
        setState(() {
          imageName = 'Failed to upload image';
        });
      }
    } catch (error) {
      setState(() {
        imageName = 'Image to large: $error';
      });
    }
  }
  // final picker = ImagePicker();
  // String imageName = '';
  // int mediaId =0;
  // Future<void> getImageFromGallery() async {
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   var imageBytes=await pickedFile!.readAsBytes();
  //   String base64= base64Encode(imageBytes);
  //   final Map<String, dynamic> payload = {
  //       "fileType": pickedFile.mimeType,
  //       "base64Image": base64,
  //       "name": pickedFile.name,
  //       "categoryName": "users",
  //     };
  //     try {
  //       final String? value = await storage.read(key: 'token');
  //       final http.Response response = await http.post(
  //         Uri.parse('${Constants.BASE_URL}/api/v1/media'),
  //         headers: {
  //           'Authorization': value.toString(),
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode(payload),
  //       );
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> responseData = jsonDecode(response.body);
  //         (responseData);
  //         imageName = responseData['name'];
  //         mediaId = responseData['id'];
  //         setState(() {});
  //       } else {
  //         ('Failed to upload image');
  //       }
  //     } catch (error) {
  //       ('An error occurred: $error');
  //     }
  //   }
  Future<void> fetchStates() async {
    String? value = await storage.read(key: 'token');
    final response = await http.get(Uri.parse('${Constants.BASE_URL}/api/v1/states'),
      headers: {
        'Authorization': value.toString(),
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<States> fetchedStates = data.map((json) => States.fromJson(json)).toList();
      if (fetchedStates.isNotEmpty) {
        // selectedState = fetchedStates[0].name;
      }
      setState(() {
        states = fetchedStates;
      });
    } else {
      throw Exception('Failed to fetch state data');
    }
  }
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool kpiChecked = false;
  bool targetChecked = false;
  bool achievementsChecked = false;
  bool tierChecked = false;
  bool ptsApplicableChecked = false;
  bool leaderboardChecked = false;
  bool pointCalculatedChecked=false;

  void saveForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? value = await storage.read(key: 'token');
        final Map<String, dynamic> payload = {
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'username': usernameController.text,
          'media': {
            'id': mediaId,
          },
          'type': selectedConfigValue,
          'stateId': selectedStateId,
          'configuration': {
            'access': {
              'kpi': kpiChecked,
              'points': pointCalculatedChecked,
              'leaderboard': leaderboardChecked,
            },
          },
        };
        final response = await http.post(
          Uri.parse('${Constants.BASE_URL}/api/v1/enrollments'),
          headers: {
            'Authorization': value.toString(),
            'Content-Type': 'application/json',
          },
          body: jsonEncode(payload),
        );
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          (jsonData);
        }
      } catch (error) {
        ('An error occurred: $error');
      }
    }
  }
  //admin.type
  Future<void> fetchConfigData() async {
    try {
      String? value = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse('${Constants.BASE_URL}/api/v1/configs/.by.name/admin.types'),
        headers: {
          'Authorization': value.toString(),
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<String> configList = (data['value'] as List).cast<String>();
        setState(() {
          configValues = configList;
        });
      } else {
        ('Failed to fetch configuration data');
      }
    } catch (error) {
      ('An error occurred: $error');
    }
  }
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    // stateController.dispose();
    // typeController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Form(
              key: _formKey,
              child: Column(children: [
                BigText(text:
                  "Enrollment",color: Colors.teal,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color:Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: firstNameController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter(RegExp(r'^[a-zA-Z]+'), allow: true),
                        LengthLimitingTextInputFormatter(60)
                      ],
                      decoration: const InputDecoration(
                        errorMaxLines: 3,
                        hintStyle:
                        TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        labelText: "First Name*",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color:Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: lastNameController,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter(RegExp(r'^[a-zA-Z]+'), allow: true),LengthLimitingTextInputFormatter(60)],
                      decoration: const InputDecoration(
                        errorMaxLines: 3,
                        hintStyle:
                        TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        labelText: "Last Name*",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color:Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: emailController,
                      // inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter(RegExp(r'^[a-zA-Z]+'), allow: true),LengthLimitingTextInputFormatter(60)],
                      decoration: const InputDecoration(
                        errorMaxLines: 3,
                        hintStyle:
                        TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        labelText: "Email*",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButtonFormField<int>(
                      value: selectedStateId,
                      items: states.toSet().toList().map((state)  {
                        return DropdownMenuItem<int>(
                          value: state.id,
                          child:  Text(state.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStateId = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'StateId*',
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select the state';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        getImageFromGallery();
                        setState(() {
                            imageName = 'Upload image'; // Show "Uploading..." while uploading
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 120,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: BigText(text: 'Choose Media',)),
                      ),
                    ),
                    // if (imageUrl.isNotEmpty)
                    Container(
                      height: 60,
                      width: 210,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          ' $imageName',
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedConfigValue,
                      items: configValues.map((value)  {
                        return DropdownMenuItem<String>(
                          // value: configValues.indexOf(value)
                         value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedConfigValue= value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Type*',
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select the state';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color:Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: usernameController,
                      enabled: true,
                      // inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter(RegExp(r'^[a-zA-Z]+'), allow: true),LengthLimitingTextInputFormatter(60)],
                      decoration: const InputDecoration(
                        errorMaxLines: 3,
                        hintStyle:
                        TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        labelText: "UserName*",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // const SizedBox(height: 10,),
                // BigText(text: 'Configuration',color: Colors.teal,),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       const Text('Kpi'), // Label for the checkbox
                //       Checkbox(
                //         value: kpiChecked,
                //         onChanged: (bool? value) {
                //           setState(() {
                //             kpiChecked = value ?? false;
                //           });
                //         },
                //       ),
                //       const SizedBox(height: 10,),
                //       const Text('Target'),
                //       Checkbox(
                //         value: targetChecked,
                //         onChanged: (bool? value) {
                //           setState(() {
                //             targetChecked =value??false;
                //           });
                //       },
                //       ),
                //       const SizedBox(height: 10,),
                //       const Text('Achievements'), // Label for the checkbox
                //       Checkbox(
                //         value: achievementsChecked,
                //         onChanged: (bool? value) {
                //           setState(() {
                //             achievementsChecked=value??false;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(5.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       const Text('Is pts applicable'),
                //       Checkbox(
                //         value: ptsApplicableChecked,
                //         onChanged: (bool? value) {
                //           setState(() {
                //             ptsApplicableChecked=value??false;
                //           });
                //         },
                //       ),
                //
                //       const Text('LeaderBoard'),
                //       Checkbox(
                //         value: leaderboardChecked,
                //         onChanged: (bool? value) {
                //           setState(() {
                //             leaderboardChecked=value??false;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(5.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       const Text('Tier*'),
                //       Checkbox(
                //         value: tierChecked,
                //         onChanged: (bool? value) {
                //           setState(() {
                //             tierChecked=value??false;
                //           });
                //         },
                //       ),
                //       const Text('Provide Calculated points'),
                //       Checkbox(
                //         value: pointCalculatedChecked,
                //         onChanged: (bool? value) {
                //           setState(() {
                //             pointCalculatedChecked=value??false;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 40,),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ElevatedButton(
                      onPressed: (){
                        saveForm();
                      },
                      child: const Text('Create Enrollment')
                  ),
                )
              ]
              ),
            )
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
