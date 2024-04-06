import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Added for FilteringTextInputFormatter
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<CroppedFile?> getCroppedFile(ImageSource imageSource, {bool isSelfie = false}) async {
  final pickedImage = isSelfie
      ? await ImagePicker().pickImage(source: imageSource, preferredCameraDevice: CameraDevice.front)
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
  int currentStep = 1;
  bool isStep1Completed = false;
  bool isStep2Completed = false;
  bool isStep3Completed = false;

  late TextEditingController nurseIdController;
  late TextEditingController dobController;
  late TextEditingController nationalityController;
  late TextEditingController locationController;
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
  String expertise = '';
  String hourlyPrice = '';
  String dailyPrice = '';
  String weeklyPrice = '';
  File? _image;
  String? _imageBase64;

  List<String> expertiseOptions = [
    'Cardiology',
    'Orthopedics',
    'Neurology',
    'Oncology',
    'Pediatrics',
    'Geriatrics',
    'Many',
  ];

  @override
  void initState() {
    super.initState();
    nurseIdController = TextEditingController();
    dobController = TextEditingController();
    nationalityController = TextEditingController();
    locationController = TextEditingController();
    experienceController = TextEditingController();
    expertiseController = TextEditingController();
    hourlyPriceController = TextEditingController();
    dailyPriceController = TextEditingController();
    weeklyPriceController = TextEditingController();
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
    super.dispose();
  }

  Future<void> _getImageFromCamera(ImageSource source, {bool isSelfie = false, bool isFrontId = false, bool isBackId = false}) async {
    CroppedFile? croppedFile = await getCroppedFile(source, isSelfie: isSelfie);
    if (croppedFile != null) {
      setState(() {
        _image = File(croppedFile.path);
        _imageBase64 = convertImageToBase64(croppedFile);
      });

      // Check if the image is for front ID or back ID and handle accordingly
      if (isFrontId) {
        // Handle front ID image
        // You can store or process the front ID image here
      } else if (isBackId) {
        // Handle back ID image
        // You can store or process the back ID image here
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Get verification'),
    leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: widget.goBack,
    ),
    ),
    body: SingleChildScrollView(
    child:
    Padding(
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
      SizedBox(width: 20),
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
        child: Text('Personal Information'),
      ),
      childrenPadding: EdgeInsets.zero,
      children: [
        ListTile(
          title: Semantics(
            label: 'Nurse ID',
            hint: 'Enter your nurse ID (numbers only)',
            child: TextField(
              controller: nurseIdController,
              decoration: InputDecoration(
                labelText: 'Enter Nurse ID',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  nurseId = value;
                  isStep1Completed = value.isNotEmpty;
                });
              },
            ),
          ),
        ),
        ListTile(
          title: Semantics(
            label: 'Date of Birth',
            hint: 'Enter your date of birth',
            child: TextField(
              controller: dobController,
              decoration: InputDecoration(
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
                    dob = selectedDate.toString();
                    dobController.text = dob;
                    isStep1Completed = true;
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
              decoration: InputDecoration(
                labelText: 'Select Nationality',
              ),
              readOnly: true,
              onTap: () async {
                // Open a dropdown for selecting nationality
                final selectedNationality = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select Nationality'),
                      content: DropdownButton<String>(
                        items: <String>[
                          'Albanian',
                          // Add more nationalities as needed
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
                    isStep1Completed = true;
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
              decoration: InputDecoration(
                labelText: 'Enter Location',
              ),
              onChanged: (value) {
                setState(() {
                  location = value;
                  isStep1Completed = true;
                });
              },
            ),
          ),
        ),
      ],
    ),
        ElevatedButton(
          onPressed: isStep1Completed ? nextStep : null,
          child: Text('Next'),
        ),
        ] else if (currentStep == 2) ...[
    ExpansionTile(
    title: Semantics(
    label: 'Uploading Info',
      hint: 'Upload your information',
      child: Text('Uploading Info'),
    ),
    childrenPadding: EdgeInsets.zero,
    children: [
    ListTile(
    title: Semantics(
    label: 'Years of Experience',
    hint: 'Enter your years of experience',
    child: TextField(
    controller: experienceController,
    decoration: InputDecoration(
    labelText: 'Years of Experience',
    ),
    keyboardType: TextInputType.number,
    onChanged: (value) {
    setState(() {
    experience = value;
    isStep2Completed = value.isNotEmpty;
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
    decoration: InputDecoration(
    labelText: 'Select Expertise',
    ),
    readOnly: true,
    onTap: () async {
    // Open a dropdown for selecting expertise
    final selectedExpertise = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text('Select your Expertise'),
    content: DropdownButton<String>(
    items: expertiseOptions.map((String value) {
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
    isStep2Completed = true;
    });
    }
    },
    ),
    ),
    ),
    ListTile(
    leading: _image == null
    ? Icon(
    Icons.account_circle,
    size: 40,
    )
        : ClipOval(
    child: Image.file(
    _image!,
    height: 80,
    width: 80,
    fit: BoxFit.cover,
    ),
    ),
    title: TextButton.icon(
    onPressed: () {
    _getImageFromCamera(
    ImageSource.camera,
    isSelfie: true,
    );
    },
    icon: Icon(
    Icons.camera_alt,
    size: 16,
    ),
    label: Text(
    'capture your passport',
    ),
    ),
    onTap: () {
    _getImageFromCamera(
    ImageSource.camera,
    isSelfie: true,
    );
    },
    ),
    ListTile(
    leading: _image == null
    ? Icon(
    Icons.account_circle,
    size: 40,
    )
        : ClipOval(
    child: Image.file(
    _image!,
    height: 80,
    width: 80,
    fit: BoxFit.cover,
    ),
    ),
    title: TextButton.icon(
    onPressed: () {
    _getImageFromCamera(
    ImageSource.camera,
    isSelfie: true,
    isFrontId: true,
    );
    },
    icon: Icon(
      Icons.camera_alt,
      size: 16,
    ),
      label: Text(
        'Capture Front ID',
      ),
    ),
      onTap: () {
        _getImageFromCamera(
          ImageSource.camera,
          isSelfie: true,
          isFrontId: true,
        );
      },
    ),
      ListTile(
        leading: _image == null
            ? Icon(
          Icons.account_circle,
          size: 40,
        )
            : ClipOval(
          child: Image.file(
            _image!,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: TextButton.icon(
          onPressed: () {
            _getImageFromCamera(
              ImageSource.camera,
              isSelfie: true,
              isBackId: true,
            );
          },
          icon: Icon(
            Icons.camera_alt,
            size: 16,
          ),
          label: Text(
            'Capture Back ID',
          ),
        ),
        onTap: () {
          _getImageFromCamera(
            ImageSource.camera,
            isSelfie: true,
            isBackId: true,
          );
        },
      ),
    ],
    ),
              ElevatedButton(
                onPressed: isStep2Completed ? nextStep : null,
                child: Text('Next'),
              ),
            ] else if (currentStep == 3) ...[
              ExpansionTile(
                title: Semantics(
                  label: 'Pricing Information',
                  hint: 'Enter your pricing information',
                  child: Text('Pricing Information'),
                ),
                childrenPadding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: Semantics(
                      label: 'Hourly Price',
                      hint: 'Enter your hourly price',
                      child: TextField(
                        controller: hourlyPriceController,
                        decoration: InputDecoration(
                          labelText: 'Hourly Price',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            hourlyPrice = value;
                          });
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Semantics(
                      label: 'Daily Price',
                      hint: 'Enter your daily price',
                      child: TextField(
                        controller: dailyPriceController,
                        decoration: InputDecoration(
                          labelText: 'Daily Price',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dailyPrice = value;
                          });
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Semantics(
                      label: 'Weekly Price',
                      hint: 'Enter your weekly price',
                      child: TextField(
                        controller: weeklyPriceController,
                        decoration: InputDecoration(
                          labelText: 'Weekly Price',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            weeklyPrice = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle submission of the form, e.g., send data to server
                },
                child: Text('Submit'),
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
}

