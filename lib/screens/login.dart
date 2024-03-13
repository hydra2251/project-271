import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project271/Designs/loadingscreen.dart';
import 'package:project271/Designs/popupalert.dart';
import 'package:project271/globalvariables.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController =
      TextEditingController(); // Added password controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 220, 225),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when the back button is pressed
          },
        ),
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the app bar elevation
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'lib/assets/nursesicon.png',
                height: 200,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PasswordField(
                controller: passwordController, // Pass the password controller
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    loginuser(context, usernameController, passwordController),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              // TextButton(
              //   onPressed: () {
              //     // Add your navigation logic for the forgot password page
              //   },
              //   child: const Text('Forgot Password?'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller; // Added controller property
  const PasswordField(
      {required this.controller}); // Modified constructor to accept controller

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // Bind the controller to the TextFormField
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

loginuser(BuildContext context, TextEditingController usernamecontroller,
    TextEditingController passwordcontroller) async {
  if (usernamecontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
    showalert(context, "Fill All the fields", AlertType.warning);
    return;
  } else {
    loginuserdatabase(context, usernamecontroller, passwordcontroller);
  }
}

Future<void> loginuserdatabase(
    BuildContext context,
    TextEditingController usernamecontroller,
    TextEditingController passwordcontroller) async {
  try {
    showLoadingDialog(context, true);
    Uri url = Uri.parse("${GlobalVariables.apilink}/User/login");
    Map<String, dynamic> userData = {
      "Username": usernamecontroller.text,
      "Password": passwordcontroller.text,
    };
    Response response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    ).timeout(const Duration(seconds: 10));
    showLoadingDialog(context, false);
    if (response.statusCode == 200) {
      showalert(context, "User Registered", AlertType.success);
      print(response.body);
    } else {
      String error = response.body;
      showalert(context, error, AlertType.warning);
    }
  } on TimeoutException catch (_) {
    showLoadingDialog(context, false);
    showalert(
        context, "The request timed out. Please try again.", AlertType.error);
  } catch (e) {
    showLoadingDialog(context, false);
    print(e);
    showalert(context, "Application Encountered an Unhandled Exception",
        AlertType.error);
  }
}
