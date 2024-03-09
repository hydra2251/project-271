import 'package:flutter/material.dart';
import 'package:project271/screens/signin.dart';
import 'package:project271/screens/signinnurse.dart'; // Import SignInClientPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client and Nurse Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClientNursePage(),
    );
  }
}

class ClientNursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgbaColor(233, 243, 245, 1), // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/nursesicon.png', // Replace 'assets/camera_icon.png' with your image asset path
              width: 200,
              height: 200,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to SignInPage when Client button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: rgbaColor(233, 243, 245, 1), // Set button color using RGBA values
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Adjust button padding
              ),
              child: Text('Client'),
            ),
            SizedBox(height: 10), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to SignInClientPage when Nurse button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NursePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: rgbaColor(233, 243, 245, 1), // Set button color using RGBA values
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Adjust button padding
              ),
              child: Text('Nurse'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to define a Color object using RGBA values
  Color rgbaColor(int r, int g, int b, double opacity) {
    return Color.fromRGBO(r, g, b, opacity);
  }
}
