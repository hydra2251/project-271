import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NursePage(),
    );
  }
}

class NursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue, // Set app bar color to blue
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Navigate back to the main page
          },
        ),
      ),
      backgroundColor: Colors.blue, // Set background color to blue
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nurse',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'lib/assets/nursesicon.png', // Replace 'assets/nurse_image.png' with your image asset path
              width: 200,
              height: 200,
              color: Colors.white,
            ),
            SizedBox(height: 20.0),
            NurseTextField(label: 'Full Name'),
            SizedBox(height: 10.0),
            NurseTextField(label: 'Username'),
            SizedBox(height: 10.0),
            NurseTextField(label: 'Password', isObscured: true),
            SizedBox(height: 10.0),
            NurseTextField(label: 'Gender'),
            SizedBox(height: 10.0),
            NurseTextField(label: 'Phone'),
            SizedBox(height: 10.0),
            NurseTextField(label: 'Email'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Set button background color to blue
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NurseTextField extends StatefulWidget {
  final String label;
  final bool isObscured;

  const NurseTextField({Key? key, required this.label, this.isObscured = false}) : super(key: key);

  @override
  _NurseTextFieldState createState() => _NurseTextFieldState();
}

class _NurseTextFieldState extends State<NurseTextField> {
  late FocusNode _focusNode;
  late bool _isFocused;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isFocused = false;

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white), // Change text color to white
      obscureText: widget.isObscured,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: _isFocused ? '' : widget.label,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)), // Set placeholder color to white with opacity
        border: InputBorder.none,
      ),
    );
  }
}
