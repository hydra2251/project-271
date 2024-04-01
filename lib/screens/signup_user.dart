// ignore_for_file: use_build_context_synchronously

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
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Create focus nodes for each text field
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastnameaFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  late TextEditingController firstnamecontroller;
  late TextEditingController lastnamecontroller;
  late TextEditingController usernamecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController phonenumbercontroller;
  late TextEditingController passwordcontroller;
  bool _obscureText = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstnamecontroller = TextEditingController();
    lastnamecontroller = TextEditingController();
    usernamecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    phonenumbercontroller = TextEditingController();
    passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose of the focus nodes when the widget is disposed
    firstnameFocusNode.dispose();
    lastnameaFocusNode.dispose();
    usernameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: rgbaColor(233, 243, 245, 1),
      appBar: AppBar(
        backgroundColor: rgbaColor(
            233, 243, 245, 1), // Change the color of the navigation bar
        automaticallyImplyLeading: true, // Hide the default back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Client', // Add text "Client" above the picture
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'lib/assets/nursesicon.png',
                  height: 120,
                ),
                const SizedBox(
                    height: 40.0), // Increase spacing below the image
                Column(
                  children: [
                    TextFormField(
                      controller: firstnamecontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]')), // Allow only letters
                      ],
                      style: const TextStyle(
                          color: Colors.blue), // Change text color
                      focusNode: firstnameFocusNode,
                      onTap: () {
                        // Set focus on the text field and clear placeholder when tapped
                        setState(() {
                          FocusScope.of(context)
                              .requestFocus(firstnameFocusNode);
                        });
                      },
                      decoration: InputDecoration(
                        labelText:
                            firstnameFocusNode.hasFocus ? '' : ' First Name',
                        labelStyle: const TextStyle(
                            color: Colors.blue), // Change label color
                        border: InputBorder.none, // Remove border
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]')), // Allow only letters
                      ],
                      controller: lastnamecontroller,
                      style: const TextStyle(
                          color: Colors.blue), // Change text color
                      focusNode: lastnameaFocusNode,
                      onTap: () {
                        // Set focus on the text field and clear placeholder when tapped
                        setState(() {
                          FocusScope.of(context)
                              .requestFocus(lastnameaFocusNode);
                        });
                      },
                      decoration: InputDecoration(
                        labelText:
                            lastnameaFocusNode.hasFocus ? '' : 'Last Name',
                        labelStyle: const TextStyle(
                            color: Colors.blue), // Change label color
                        border: InputBorder.none, // Remove border
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: usernamecontroller,
                      style: const TextStyle(
                          color: Colors.blue), // Change text color
                      focusNode: usernameFocusNode,
                      onTap: () {
                        // Set focus on the text field and clear placeholder when tapped
                        setState(() {
                          FocusScope.of(context)
                              .requestFocus(usernameFocusNode);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: usernameFocusNode.hasFocus ? '' : 'Username',
                        labelStyle: const TextStyle(
                            color: Colors.blue), // Change label color
                        border: InputBorder.none, // Remove border
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: phonenumbercontroller,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(8),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]')), // Allow only numbers
                      ],
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                          color: Colors.blue), // Change text color
                      focusNode: phoneFocusNode,
                      onTap: () {
                        // Set focus on the text field and clear placeholder when tapped
                        setState(() {
                          FocusScope.of(context).requestFocus(phoneFocusNode);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: phoneFocusNode.hasFocus ? '' : 'Phone',
                        labelStyle: const TextStyle(
                            color: Colors.blue), // Change label color
                        border: InputBorder.none, // Remove border
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: emailcontroller,
                      style: const TextStyle(
                          color: Colors.blue), // Change text color
                      focusNode: emailFocusNode,
                      onTap: () {
                        // Set focus on the text field and clear placeholder when tapped
                        setState(() {
                          FocusScope.of(context).requestFocus(emailFocusNode);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: emailFocusNode.hasFocus ? '' : 'Email',
                        labelStyle: const TextStyle(
                            color: Colors.blue), // Change label color
                        border: InputBorder.none, // Remove border
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      style: const TextStyle(
                          color: Colors.blue), // Change text color
                      focusNode: passwordFocusNode,
                      onTap: () {
                        // Set focus on the text field and clear placeholder when tapped
                        setState(() {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        });
                      },
                      obscureText:
                          _obscureText, // Hide or reveal password based on this value
                      decoration: InputDecoration(
                        labelText: usernameFocusNode.hasFocus ? '' : 'Password',
                        labelStyle: const TextStyle(
                            color: Colors.blue), // Change label color
                        border: InputBorder.none, // Remove border
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText =
                                  !_obscureText; // Toggle obscure text
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    signupuser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color rgbaColor(int r, int g, int b, double opacity) {
    return Color.fromRGBO(r, g, b, opacity);
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
        "RoleId": 1
      };
      Response response = await post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      ).timeout(const Duration(seconds: 10));
      showLoadingDialog(context, false);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('UserId', responseData['userId'].toString());
        prefs.setString('Username', usernamecontroller.text);
        prefs.setString('Token', responseData['token'].toString());
        prefs.setString('RoleId', '1');
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
