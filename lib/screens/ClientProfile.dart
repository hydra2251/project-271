import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project271/globalvariables.dart';
import 'package:project271/screens/adminpage.dart';
import 'package:project271/screens/advancedsignup.dart';
import 'package:project271/screens/chooseavailabledates.dart';
import 'package:project271/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({Key? key}) : super(key: key);

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  Map<String, dynamic> userinfo = {};
  CroppedFile? profilepicture;
  String? RoleId;

  @override
  void initState() {
    super.initState();
    loaduserinfo();
  }

  Future<void> loaduserinfo() async {
    Map<String, dynamic> userInformation = await getuserinfobyuserid();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userinfo = userInformation;
      RoleId = preferences.getString("RoleId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showImagePickerOption(context);
                },
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      width: 120.0,
                      height: 120.0,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        backgroundImage: userinfo['profile'] != null
                            ? MemoryImage(
                                base64Decode(userinfo['profile'].toString()))
                            : null,
                        child: userinfo['profile'] == null
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              )
                            : null,
                      ),
                    ),
                    const Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            if (userinfo['profile'] !=
                null) // Show delete button only if profile picture exists
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      userinfo['profile'] = null;
                      deleteprofilepicture();
                    });
                  },
                  child: const Text('Delete Image'),
                ),
              ),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${userinfo['firstname']} ${userinfo["lastname"]}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 5.0), // Add some space
                Text(
                  userinfo['username'] ?? '', // Display username
                  style: TextStyle(
                    color: Colors.grey[600], // Smaller text color
                    fontSize: 16.0, // Smaller font size
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  userinfo['email'] ?? '',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: Colors.grey[400],
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  userinfo['phonenumber'] ?? '',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => logout(context),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(200),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseAvailableDates()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(200),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Choose Available Dates',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            if (RoleId == '0')
              const SizedBox(
                height: 10,
              ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(200),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Admin Page',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteprofilepicture() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = int.tryParse(prefs.getString("UserId") ?? '') ?? 0;
      Uri url = Uri.parse(
          "${GlobalVariables.apilink}/User/deleteprofilepicture?userid=$userId");
      Response response = await post(
        url,
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(minutes: 1));
      if (response.statusCode == 200) {
        print("LETSS GOOO");
      }
    } on TimeoutException catch (_) {
    } catch (e) {
      print(e);
    }
  }

  Future<void> changeprofilepicture(
    ImageSource imageSource,
  ) async {
    final returnimage = await ImagePicker().pickImage(source: imageSource);
    if (returnimage == null) return null;
    CroppedFile? croppedfile = await ImageCropper().cropImage(
      sourcePath: returnimage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    Navigator.pop(context);
    if (croppedfile == null) return null;
    setState(() {
      userinfo["profile"] = convertImageToBase64(croppedfile);
      uploadprofilepicture(userinfo["profile"]);
    });
  }

  Future<Map<String, dynamic>> getuserinfobyuserid() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = int.tryParse(prefs.getString("UserId") ?? '') ?? 0;
      Uri url = Uri.parse(
          "${GlobalVariables.apilink}/User/getuserprofilebyuserid?userid=$userId");
      var response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(minutes: 1));

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        return {};
      }
    } on TimeoutException catch (_) {
      return {};
    }
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => changeprofilepicture(ImageSource.gallery),
                  child: const SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 70,
                        ),
                        Text("Gallery")
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => changeprofilepicture(ImageSource.camera),
                  child: const SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 70,
                        ),
                        Text("Camera")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> uploadprofilepicture(String base64image) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = int.tryParse(prefs.getString("UserId") ?? '') ?? 0;
    Uri url = Uri.parse("${GlobalVariables.apilink}/User/addprofilepicture");
    Map<String, dynamic> userData = {
      "Id": userId,
      "ProfilePicture": base64image,
    };
    Response response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    ).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      print("LETSS GOOO");
    }
  } on TimeoutException catch (_) {
  } catch (e) {
    print(e);
  }
}

void logout(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    (Route<dynamic> route) =>
        false, // This predicate will remove all routes from the stack
  );
}
