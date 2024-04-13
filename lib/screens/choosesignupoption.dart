import 'package:flutter/material.dart';
import 'package:project271/screens/login.dart';
import 'package:project271/screens/signup_nurse.dart';

class ChooseSignUpOption extends StatelessWidget {
  const ChooseSignUpOption({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientNursePage();
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
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
