import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project271/Designs/loadingdesign.dart';
import 'package:project271/Designs/popupalert.dart';
import 'package:project271/globalvariables.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<CroppedFile?> getCroppedFile(ImageSource imageSource,
    {bool isSelfie = false}) async {
  final pickedImage = isSelfie
      ? await ImagePicker().pickImage(
          source: imageSource, preferredCameraDevice: CameraDevice.front)
      : await ImagePicker().pickImage(source: imageSource);

  if (pickedImage == null) return null;

  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: pickedImage.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
    ],
  );

  return croppedFile;
}

String convertImageToBase64(CroppedFile? croppedFile) {
  Uint8List image = File(croppedFile!.path).readAsBytesSync();
  String base64string = base64Encode(image);
  return base64string;
}

void main() {
  runApp(AdvancedSignUpPage());
}

class AdvancedSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(
        goBack: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  final VoidCallback goBack;

  SignUpPage({required this.goBack});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late Future<dynamic>? nurseadvancedinfo;
  int currentStep = 1;
  bool isStep1Completed = false;
  bool isStep2Completed = false;
  bool isStep3Completed = false;

  late TextEditingController nurseIdController;
  late TextEditingController dobController;
  late TextEditingController nationalityController;
  late TextEditingController locationController;
  late TextEditingController bioController;
  late TextEditingController experienceController;
  late TextEditingController expertiseController;
  late TextEditingController hourlyPriceController;
  late TextEditingController dailyPriceController;
  late TextEditingController weeklyPriceController;

  String nurseId = '';
  String dob = '';
  String nationality = '';
  String location = '';
  String experience = '';
  String bio = '';
  String expertise = '';
  String hourlyPrice = '';
  String dailyPrice = '';
  String weeklyPrice = '';
  CroppedFile? passportimage;
  CroppedFile? idFrontImage;
  CroppedFile? idBackimage;
  String? passportbase64;
  String? idfrontimagebase64;
  String? idbackimagebase64;
  String? passportonline;
  String? idfrontonline;
  String? idbackonline;

  List<String> expertiseOptions = [
    'Cardiology',
    'Orthopedics',
    'Neurology',
    'Oncology',
    'Pediatrics',
    'Geriatrics',
  ];

  @override
  void initState() {
    super.initState();
    nurseIdController = TextEditingController();
    dobController = TextEditingController();
    nationalityController = TextEditingController();
    locationController = TextEditingController();
    bioController = TextEditingController();
    experienceController = TextEditingController();
    expertiseController = TextEditingController();
    hourlyPriceController = TextEditingController();
    dailyPriceController = TextEditingController();
    weeklyPriceController = TextEditingController();
    someFunction();
  }

  void someFunction() async {
    dynamic nurseadvancedinfo = await getnursesignupadvancedinfo();
    if (nurseadvancedinfo != null) {
      dobController.text = nurseadvancedinfo["dateofBirth"].toString() ?? '';
      nationalityController.text =
          nurseadvancedinfo["nationality"].toString() ?? '';
      locationController.text = nurseadvancedinfo["location"].toString() ?? '';
      bioController.text = nurseadvancedinfo["bio"].toString() ?? '';
      experienceController.text =
          nurseadvancedinfo["yearsOfExperience"].toString() ?? '';
      expertiseController.text =
          nurseadvancedinfo["expertise"].toString() ?? '';
      hourlyPriceController.text =
          nurseadvancedinfo["hourlyPrice"]?.toString() ?? '';
      dailyPriceController.text =
          nurseadvancedinfo["dailyPrice"]?.toString() ?? '';
      weeklyPriceController.text =
          nurseadvancedinfo["weeklyPrice"]?.toString() ?? '';
      passportonline = nurseadvancedinfo["passportimage"];
      idbackonline = nurseadvancedinfo["idBackImage"];
      idfrontonline = nurseadvancedinfo["idFrontImage"];
      isStep1Completed = true;
      isStep2Completed = true;
      isStep3Completed = true;
      setState(() {});
    }
  }

  @override
  void dispose() {
    nurseIdController.dispose();
    dobController.dispose();
    nationalityController.dispose();
    locationController.dispose();
    experienceController.dispose();
    expertiseController.dispose();
    hourlyPriceController.dispose();
    dailyPriceController.dispose();
    weeklyPriceController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void nextStep() {
    if (currentStep == 1 && !isStep1Completed) return;
    if (currentStep == 2 && !isStep2Completed) return;
    setState(() {
      currentStep++;
    });
  }

  void previousStep() {
    setState(() {
      currentStep--;
    });
  }

  void checkifstep1iscomplete() {
    if (dobController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        nationalityController.text.isNotEmpty &&
        experienceController.text.isNotEmpty &&
        expertiseController.text.isNotEmpty &&
        bioController.text.isNotEmpty) {
      isStep1Completed = true;
    } else {
      isStep1Completed = false;
    }
  }

  void checkIfStep2IsComplete() {
    // Step 2 is considered complete if the passport image is not null, OR both ID front and back images are not null.
    // If only one of the ID images is uploaded, the user is required to upload the other one.
    if (passportbase64 != null) {
      isStep2Completed = true;
    }
    if (passportbase64 != null &&
        idfrontimagebase64 == null &&
        idbackimagebase64 != null) {
      isStep2Completed = false;
    }
    if (passportbase64 != null &&
        idfrontimagebase64 != null &&
        idbackimagebase64 == null) {
      isStep2Completed = false;
    }
    if (idfrontimagebase64 != null && idbackimagebase64 != null) {
      isStep2Completed = true;
    }
  }

  void checkifstep3iscomplete() {
    if (hourlyPriceController.text.isNotEmpty &&
        weeklyPriceController.text.isNotEmpty &&
        dailyPriceController.text.isNotEmpty) {
      isStep3Completed = true;
    } else {
      isStep3Completed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get verification'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.goBack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Steps indicator
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 1; i <= 3; i++)
                    Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentStep >= i ? Colors.blue : Colors.grey,
                          ),
                        ),
                        if (i < 3)
                          Container(
                            width: 2,
                            height: 20,
                            color: currentStep > i ? Colors.blue : Colors.grey,
                          ),
                      ],
                    ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Form fields for each step
                    if (currentStep == 1) ...[
                      ExpansionTile(
                        title: Semantics(
                          label: 'Personal Information',
                          hint: 'Enter your personal information',
                          child: const Text('Personal Information'),
                        ),
                        childrenPadding: EdgeInsets.zero,
                        children: [
                          ListTile(
                            title: Semantics(
                              label: 'Date of Birth',
                              hint: 'Enter your date of birth',
                              child: TextField(
                                controller: dobController,
                                decoration: const InputDecoration(
                                  labelText: 'Enter Date of Birth',
                                ),
                                readOnly: true,
                                onTap: () async {
                                  // Open a date picker dialog
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (selectedDate != null) {
                                    setState(() {
                                      dobController.text =
                                          DateFormat('dd-MM-yyyy')
                                              .format(selectedDate);
                                      checkifstep1iscomplete();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Semantics(
                              label: 'Nationality',
                              hint: 'Select your nationality',
                              child: TextField(
                                controller: nationalityController,
                                decoration: const InputDecoration(
                                  labelText: 'Select Nationality',
                                ),
                                readOnly: true,
                                onTap: () async {
                                  // Open a dropdown for selecting nationality
                                  final selectedNationality =
                                      await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Select Nationality'),
                                        content: DropdownButton<String>(
                                          items: <String>[
                                            'Lebanese',
                                            'American',
                                            'British',
                                            'Canadian',
                                            // Add more nationalities as needed
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            Navigator.pop(context, value);
                                          },
                                        ),
                                      );
                                    },
                                  );
                                  if (selectedNationality != null) {
                                    setState(() {
                                      nationality = selectedNationality;
                                      nationalityController.text = nationality;
                                      checkifstep1iscomplete();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Semantics(
                              label: 'Location',
                              hint: 'Enter your location',
                              child: TextField(
                                controller: locationController,
                                decoration: const InputDecoration(
                                  labelText: 'Enter Location',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    location = value;
                                    checkifstep1iscomplete();
                                  });
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Semantics(
                              label: 'Years of Experience',
                              hint: 'Enter your years of experience',
                              child: TextField(
                                controller: experienceController,
                                decoration: const InputDecoration(
                                  labelText: 'Years of Experience',
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    experience = value;
                                    checkifstep1iscomplete();
                                  });
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Semantics(
                              label: 'Bio',
                              hint: 'Tell us about you',
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(300),
                                ],
                                controller: bioController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  labelText: 'Bio',
                                ),
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    bio = value;
                                    checkifstep1iscomplete();
                                  });
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Semantics(
                              label: 'Expertise',
                              hint: 'Select your expertise',
                              child: TextField(
                                controller: expertiseController,
                                decoration: const InputDecoration(
                                  labelText: 'Select Expertise',
                                ),
                                readOnly: true,
                                onTap: () async {
                                  // Open a dropdown for selecting expertise
                                  final selectedExpertise =
                                      await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Select your Expertise'),
                                        content: DropdownButton<String>(
                                          items: expertiseOptions
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            Navigator.pop(context, value);
                                          },
                                        ),
                                      );
                                    },
                                  );
                                  if (selectedExpertise != null) {
                                    setState(() {
                                      expertise = selectedExpertise;
                                      expertiseController.text = expertise;
                                      checkifstep1iscomplete();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: isStep1Completed ? nextStep : null,
                        child: const Text('Next'),
                      ),
                    ] else if (currentStep == 2) ...[
                      ExpansionTile(
                        title: Semantics(
                          label: 'Upload Verification Images',
                          hint: 'Upload your information',
                          child: const Text('Uploading Info'),
                        ),
                        childrenPadding: EdgeInsets.zero,
                        children: [
                          ListTile(
                            leading: passportbase64 != null
                                ? SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.memory(
                                        base64Decode(passportbase64!)),
                                  )
                                : passportonline != null
                                    ? SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.network(passportonline!),
                                      )
                                    : const SizedBox(),
                            title: TextButton.icon(
                              onPressed: () {
                                showImagePickerOption(
                                  context,
                                  0,
                                );
                              },
                              icon: const Icon(
                                Icons.image,
                                size: 16,
                              ),
                              label: const Text(
                                'Choose passport Image',
                              ),
                            ),
                            onTap: () {
                              showImagePickerOption(
                                context,
                                0,
                              );
                            },
                          ),
                          ListTile(
                            leading: idfrontimagebase64 != null
                                ? SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.memory(
                                        base64Decode(idfrontimagebase64!)),
                                  )
                                : idfrontonline != null
                                    ? SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.network(idfrontonline!),
                                      )
                                    : const SizedBox(),
                            title: TextButton.icon(
                              onPressed: () {
                                showImagePickerOption(context, 1);
                              },
                              icon: const Icon(
                                Icons.image,
                                size: 16,
                              ),
                              label: const Text(
                                'Choose Front ID Image',
                              ),
                            ),
                            onTap: () {
                              showImagePickerOption(context, 1);
                            },
                          ),
                          ListTile(
                            leading: idbackimagebase64 != null
                                ? SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.memory(
                                        base64Decode(idbackimagebase64!)),
                                  )
                                : idbackonline != null
                                    ? SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.network(idbackonline!),
                                      )
                                    : const SizedBox(),
                            title: TextButton.icon(
                              onPressed: () {
                                showImagePickerOption(context, 2);
                              },
                              icon: const Icon(
                                Icons.image,
                                size: 16,
                              ),
                              label: const Text(
                                'Choose Back Id Image',
                              ),
                            ),
                            onTap: () {
                              showImagePickerOption(
                                context,
                                2,
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isStep2Completed ? nextStep : null,
                              child: const Text('Next'),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: previousStep,
                              child: const Text('Back'),
                            ),
                          ),
                        ],
                      ),
                    ] else if (currentStep == 3) ...[
                      ExpansionTile(
                        title: Semantics(
                          label: 'Pricing Information',
                          hint: 'Enter your pricing information',
                          child: const Text('Pricing Information'),
                        ),
                        childrenPadding: EdgeInsets.zero,
                        children: [
                          ListTile(
                            title: Semantics(
                              label: 'Hourly Price in USD',
                              hint: 'Enter your hourly price',
                              child: TextField(
                                controller: hourlyPriceController,
                                decoration: const InputDecoration(
                                  labelText: 'Hourly Price',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    hourlyPrice = value;
                                    checkifstep3iscomplete();
                                  });
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Semantics(
                              label: 'Daily Price in USD',
                              hint: 'Enter your daily price',
                              child: TextField(
                                controller: dailyPriceController,
                                decoration: const InputDecoration(
                                  labelText: 'Daily Price',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    dailyPrice = value;
                                    checkifstep3iscomplete();
                                  });
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Semantics(
                              label: 'Weekly Price in USD',
                              hint: 'Enter your weekly price',
                              child: TextField(
                                controller: weeklyPriceController,
                                decoration: const InputDecoration(
                                  labelText: 'Weekly Price',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    weeklyPrice = value;
                                    checkifstep3iscomplete();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isStep3Completed == false
                                  ? null
                                  : uploadadvancedinfo,
                              child: const Text('Submit'),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: previousStep,
                              child: const Text('Back'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void uploadadvancedinfo() async {
    showLoadingDialog(context, true);

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      Uri url = Uri.parse("${GlobalVariables.apilink}/User/uploadadvancedinfo");
      Map<String, dynamic> userData = {
        "nurseId": int.tryParse(preferences.getString("UserId").toString()),
        "dateofBirth": dobController.text,
        "nationality": nationalityController.text,
        "location": locationController.text,
        "yearsOfExperience": experienceController.text,
        "bio": bioController.text,
        "expertise": expertiseController.text,
        "passportimage":
            passportbase64 != null ? passportbase64 : passportonline,
        "idFrontImage":
            idfrontimagebase64 != null ? idfrontimagebase64 : idfrontonline,
        "idBackImage":
            idbackimagebase64 != null ? idbackimagebase64 : idbackonline,
        "hourlyPrice": double.tryParse(hourlyPriceController.text),
        "dailyPrice": double.tryParse(dailyPriceController.text),
        "weeklyPrice": double.tryParse(weeklyPriceController.text)
      };
      Response response = await post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        Navigator.of(context, rootNavigator: true).pop();
        showalert(context, "Advanced Info Uploaded", AlertType.success);
      }
    } on TimeoutException catch (_) {
      Navigator.of(context, rootNavigator: true).pop();
      showalert(
          context, "The request timed out. Please try again.", AlertType.error);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      print(e);
      showalert(context, "Application Encountered an Unhandled Exception",
          AlertType.error);
    }
  }

  Future<dynamic>? getnursesignupadvancedinfo() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int? nurseid = int.tryParse(preferences.getString("UserId").toString());

      Uri url = Uri.parse(
          "${GlobalVariables.apilink}/User/getnursesignupadvancedinfo?userid=$nurseid");
      Response response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 20));
      if ((response.statusCode == 200)) {
        return jsonDecode(response.body);
      }
    } on TimeoutException catch (_) {
      return null;
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      print(e);
      showalert(context, "Application Encountered an Unhandled Exception",
          AlertType.error);
    }
  }

  String convertCroppedimagetobase64(CroppedFile? croppedFile) {
    Uint8List image = File(croppedFile!.path).readAsBytesSync();
    String base64string = base64Encode(image);
    return base64string;
  }

  String convertNetworkimagetobase64(File imagenetwork) {
    Uint8List image = File(imagenetwork.path).readAsBytesSync();
    String base64string = base64Encode(image);
    return base64string;
  }

  showImagePickerOption(BuildContext context, int imagetype) {
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
                      onTap: () =>
                          pickimage(context, ImageSource.gallery, imagetype),
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
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () =>
                          pickimage(context, ImageSource.camera, imagetype),
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
                    )),
                  ],
                ),
              ),
            ));
  }

  Future<void> pickimage(
      BuildContext context, ImageSource imageSource, int imagetype) async {
    CroppedFile? file = await getcroppedfile(imageSource);

    if (file == null) {
      return;
    }
    if (imagetype == 0) {
      passportbase64 = convertCroppedimagetobase64(file);
    }
    if (imagetype == 1) {
      idfrontimagebase64 = convertCroppedimagetobase64(file);
    }
    if (imagetype == 2) {
      idbackimagebase64 = convertCroppedimagetobase64(file);
    }
    Navigator.pop(context);
    checkIfStep2IsComplete();
    setState(() {});
  }

  Future<CroppedFile?> getcroppedfile(ImageSource imageSource,
      {bool isSelfie = false}) async {
    final returnimage = isSelfie == false
        ? await ImagePicker().pickImage(source: imageSource)
        : await ImagePicker().pickImage(
            source: imageSource, preferredCameraDevice: CameraDevice.front);
    if (returnimage == null) return null;
    CroppedFile? cropppedfile = await ImageCropper().cropImage(
      sourcePath: returnimage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    return cropppedfile;
  }
}
