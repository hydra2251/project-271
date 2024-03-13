import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:project271/Designs/loadingscreen.dart';
import 'package:project271/Designs/popupalert.dart';
import 'package:project271/globalvariables.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NursePage(),
    );
  }
}

class NursePage extends StatefulWidget {
  const NursePage({super.key});

  @override
  State<NursePage> createState() => _NursePageState();
}

class _NursePageState extends State<NursePage> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue, // Set app bar color to blue
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Navigate back to the main page
          },
        ),
      ),
      backgroundColor: Colors.blue, // Set background color to blue
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Nurse',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                Image.asset(
                  'lib/assets/nursesicon.png',
                  height: 120,
                ),
                const SizedBox(height: 20.0),
                NurseTextField(
                  label: 'First Name',
                  controller: firstnamecontroller,
                  isObscured: false,
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Last Name',
                  controller: lastnamecontroller,
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Username',
                  controller: usernamecontroller,
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Email',
                  controller: emailcontroller,
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Phone',
                  controller: phonenumbercontroller,
                  numbersonly: true,
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Password',
                  controller: passwordcontroller,
                  isObscured: true,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => signupuser(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Set button background color to blue
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signupuser() {
    if (firstnamecontroller.text.isEmpty ||
        lastnamecontroller.text.isEmpty ||
        usernamecontroller.text.isEmpty ||
        emailcontroller.text.isEmpty ||
        phonenumbercontroller.text.isEmpty ||
        passwordcontroller.text.isEmpty) {
      showalert(context, "Fill all the Fields", AlertType.warning);
      return;
    }
    if (phonenumbercontroller.text.length != 8) {
      showalert(context, "Phone Number must be 8 digits", AlertType.warning);
      phonenumbercontroller.text = "";
      return;
    }
    if (!EmailValidator.validate(emailcontroller.text)) {
      showalert(context, "Enter a Valid Email", AlertType.warning);
      emailcontroller.text = "";
      return;
    }
    showLoadingDialog(context, true);
    registeruser();
  }

  Future<void> registeruser() async {
    try {
      Uri url = Uri.parse("${GlobalVariables.apilink}/User/register");
      Map<String, dynamic> userData = {
        "Username": usernamecontroller.text,
        "FirstName": firstnamecontroller.text,
        "LastName": lastnamecontroller.text,
        "PhoneNumber": phonenumbercontroller.text,
        "Password": passwordcontroller.text,
        "Email": emailcontroller.text,
        "RoleId": 2
      };
      Response response = await post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      ).timeout(const Duration(seconds: 10));
      showLoadingDialog(context, false);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print(responseData);
        showalert(context, "User Registered", AlertType.success);
      } else {
        String error = response.body;
        showalert(context, error, AlertType.warning);
      }
    } on TimeoutException catch (_) {
      showLoadingDialog(context, false);
      showalert(
          context, "The request timed out. Please try again.", AlertType.error);
    } catch (e) {
      print(e);
      showalert(context, "Application Encountered an Unhandled Exception",
          AlertType.error);
    }
  }
}

class NurseTextField extends StatefulWidget {
  final String label;
  final bool isObscured;
  final TextEditingController controller;
  final bool numbersonly;

  const NurseTextField(
      {Key? key,
      required this.label,
      this.isObscured = false,
      required this.controller,
      this.numbersonly = false})
      : super(key: key);

  @override
  _NurseTextFieldState createState() => _NurseTextFieldState();
}

class _NurseTextFieldState extends State<NurseTextField> {
  late FocusNode _focusNode;
  late bool _isFocused;

  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isFocused = false;

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          inputFormatters: widget.numbersonly
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(8)
                ]
              : [],
          keyboardType:
              widget.numbersonly ? TextInputType.phone : TextInputType.text,
          style: const TextStyle(color: Colors.white),
          obscureText: (widget.isObscured && !_showPassword),
          focusNode: _focusNode,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: _isFocused ? '' : widget.label,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
            border: InputBorder.none,
          ),
        ),
        if (widget.isObscured)
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.white.withOpacity(0.7),
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
          ),
      ],
    );
  }
}
