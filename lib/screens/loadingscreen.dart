// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project271/globalvariables.dart';
import 'package:project271/screens/choosesignupoption.dart';
import 'package:project271/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('Username');
    final String? token = prefs.getString('Token');

    if (username != null) {
      try {
        Uri url = Uri.parse(
            "${GlobalVariables.apilink}/User/test?username=$username");

        Response response = await post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${token}"
          },
        ).timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage())); //
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ChooseSignUpOption())); //
        }
      } on TimeoutException catch (_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ChooseSignUpOption()));
      }

      MaterialPageRoute(builder: (context) => LoginPage());
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ChooseSignUpOption()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity:
              1.0, // Since we're not animating opacity, set it to fully visible
          duration: const Duration(seconds: 2), // Duration of the fade effect
          curve: Curves.easeInCirc,
          child: Image.asset(
              'lib/assets/nursesicon.png'), // Your app's icon or splash image
        ),
      ),
    );
  }
}
