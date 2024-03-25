import 'package:flutter/material.dart';
import 'package:project271/screens/signup_user.dart';
import 'package:project271/screens/signup_nurse.dart';
import 'package:project271/screens/login.dart';
import 'package:project271/screens/advancedsignup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
=======

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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NursePage()),
                );
              },
              child: const Text(
                'Nurse',
                style: TextStyle(
                  fontFamily: 'LilyScriptOne',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 200, 220, 225),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: const Text(
                'Client',
                style: TextStyle(
                  fontFamily: 'LilyScriptOne',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 200, 220, 225),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AdvancedSignUpPage()), // Link to AdvancedSignUp page
                );
              },
              child: const Text(
                'Verify',
                style: TextStyle(
                  fontFamily: 'LilyScriptOne',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 200, 220, 225),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(
                  fontFamily: 'LilyScriptOne',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
