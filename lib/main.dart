import 'package:flutter/material.dart';
import 'package:project271/screens/signup_user.dart';
import 'package:project271/screens/signup_nurse.dart';
import 'package:project271/screens/login.dart';

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
      backgroundColor: rgbaColor(233, 243, 245, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/nursesicon.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: rgbaColor(233, 243, 245, 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text('Client'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NursePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: rgbaColor(233, 243, 245, 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text('Nurse'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: rgbaColor(233, 243, 245, 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Color rgbaColor(int r, int g, int b, double opacity) {
    return Color.fromRGBO(r, g, b, opacity);
  }
}
