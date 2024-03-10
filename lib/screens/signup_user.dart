import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  FocusNode nameFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    // Dispose of the focus nodes when the widget is disposed
    nameFocusNode.dispose();
    ageFocusNode.dispose();
    genderFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgbaColor(233, 243, 245, 1),
      appBar: AppBar(
        backgroundColor: rgbaColor(
            233, 243, 245, 1), // Change the color of the navigation bar
        automaticallyImplyLeading: false, // Hide the default back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 40.0), // Increase spacing below the image
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.blue), // Change text color
                    focusNode: nameFocusNode,
                    onTap: () {
                      // Set focus on the text field and clear placeholder when tapped
                      setState(() {
                        FocusScope.of(context).requestFocus(nameFocusNode);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: nameFocusNode.hasFocus ? '' : 'Name',
                      labelStyle: const TextStyle(
                          color: Colors.blue), // Change label color
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.blue), // Change text color
                    focusNode: ageFocusNode,
                    onTap: () {
                      // Set focus on the text field and clear placeholder when tapped
                      setState(() {
                        FocusScope.of(context).requestFocus(ageFocusNode);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: ageFocusNode.hasFocus ? '' : 'Age',
                      labelStyle: const TextStyle(
                          color: Colors.blue), // Change label color
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.blue), // Change text color
                    focusNode: genderFocusNode,
                    onTap: () {
                      // Set focus on the text field and clear placeholder when tapped
                      setState(() {
                        FocusScope.of(context).requestFocus(genderFocusNode);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: genderFocusNode.hasFocus ? '' : 'Gender',
                      labelStyle: const TextStyle(
                          color: Colors.blue), // Change label color
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
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
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add your sign-in logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text('Sign Up'),
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
