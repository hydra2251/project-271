import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project271/screens/signup_user.dart';
import 'package:project271/screens/signup_nurse.dart';
import 'package:project271/screens/login.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Client and Nurse Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClientNursePage(),
    );
  }
}

class ClientNursePage extends StatelessWidget {
  const ClientNursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 200, 220, 225), // Adjust the color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/nursesicon.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Would you like to sign up as a nurse or\nclient?',
              style: TextStyle(
                fontFamily: 'LilyScriptOne',
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NursePage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.transparent,
                child: const Text(
                  'Nurse',
                  style: TextStyle(
                    fontFamily: 'LilyScriptOne',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.transparent,
                child: const Text(
                  'Client',
                  style: TextStyle(
                    fontFamily: 'LilyScriptOne',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.transparent,
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    fontFamily: 'LilyScriptOne',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
