import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int currentStep = 1;

  void nextStep() {
    setState(() {
      currentStep++;
    });
  }

  void previousStep() {
    setState(() {
      currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nurse Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Steps indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 3; i++)
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentStep >= i ? Colors.blue : Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        i.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            // Form fields for each step
            if (currentStep == 1) ...[
              ExpansionTile(
                title: Text('Step 1: Personal Information'),
                children: [
                  ListTile(
                    title: Text('Enter Full Name'),
                    onTap: () {
                      // Navigate to a page to collect full name
                      // You can implement navigation using Navigator.push
                      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => FullNamePage()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: nextStep,
                child: Text('Next'),
              ),
            ] else if (currentStep == 2) ...[
              ExpansionTile(
                title: Text('Step 2: Account Information'),
                children: [
                  ListTile(
                    title: Text('Enter Username'),
                    onTap: () {
                      // Navigate to a page to collect username
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: nextStep,
                child: Text('Next'),
              ),
              TextButton(
                onPressed: previousStep,
                child: Text('Back'),
              ),
            ] else if (currentStep == 3) ...[
              ExpansionTile(
                title: Text('Step 3: Security Information'),
                children: [
                  ListTile(
                    title: Text('Enter Password'),
                    onTap: () {
                      // Navigate to a page to collect password
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle sign up submission
                },
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: previousStep,
                child: Text('Back'),

              ),
            ],
          ],
        ),
      ),
    );
  }
}