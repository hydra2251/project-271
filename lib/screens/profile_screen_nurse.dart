// profile_screen_nurse.dart
import 'package:flutter/material.dart';

class ProfileScreenNurse extends StatelessWidget {
  const ProfileScreenNurse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.account_circle,
              size: 100,
            ),
            Text(
              'Nurse Profile',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
