import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
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
        backgroundColor: rgbaColor(233, 243, 245, 1), // Change the color of the navigation bar
        automaticallyImplyLeading: false, // Hide the default back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Client', // Add text "Client" above the picture
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 10.0),
            Image.asset(
              'lib/assets/nursesicon.png',
              width: 200.0, // Adjust the width of the image
              height: 200.0, // Adjust the height of the image
            ),
            SizedBox(height: 40.0), // Increase spacing below the image
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.blue), // Change text color
                    focusNode: nameFocusNode,
                    onTap: () {
                      // Set focus on the text field and clear placeholder when tapped
                      setState(() {
                        FocusScope.of(context).requestFocus(nameFocusNode);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: nameFocusNode.hasFocus ? '' : 'Name',
                      labelStyle: TextStyle(color: Colors.blue), // Change label color
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    style: TextStyle(color: Colors.blue), // Change text color
                    focusNode: ageFocusNode,
                    onTap: () {
                      // Set focus on the text field and clear placeholder when tapped
                      setState(() {
                        FocusScope.of(context).requestFocus(ageFocusNode);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: ageFocusNode.hasFocus ? '' : 'Age',
                      labelStyle: TextStyle(color: Colors.blue), // Change label color
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    style: TextStyle(color: Colors.blue), // Change text color
                    focusNode: genderFocusNode,
                    onTap: () {
                      // Set focus on the text field and clear placeholder when tapped
                      setState(() {
                        FocusScope.of(context).requestFocus(genderFocusNode);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: genderFocusNode.hasFocus ? '' : 'Gender',
                      labelStyle: TextStyle(color: Colors.blue), // Change label color
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    style: TextStyle(color: Colors.blue), // Change text color
                    focusNode: phoneFocusNode,
                    onTap: () {
                      // Set focus on the text field and clear placeholder when tapped
                      setState(() {
                        FocusScope.of(context).requestFocus(phoneFocusNode);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: phoneFocusNode.hasFocus ? '' : 'Phone',
                      labelStyle: TextStyle(color: Colors.blue), // Change label color
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    style: TextStyle(color: Colors.blue), // Change text color
                    focusNode: emailFocusNode,
                    onTap: () {
                      // Set focus on the text field and clear placeholder when tapped
                      setState(() {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: emailFocusNode.hasFocus ? '' : 'Email',
                      labelStyle: TextStyle(color: Colors.blue), // Change label color
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add your sign-in logic here
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
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
