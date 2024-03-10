import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NursePage(),
    );
  }
}

class NursePage extends StatelessWidget {
  const NursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue, // Set app bar color to blue
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Navigate back to the main page
          },
        ),
      ),
      backgroundColor: Colors.blue, // Set background color to blue
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Nurse',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              'lib/assets/nursesicon.png',
              height: 120,
            ),
            const SizedBox(height: 20.0),
            const NurseTextField(label: 'Full Name'),
            const SizedBox(height: 10.0),
            const NurseTextField(label: 'Username'),
            const SizedBox(height: 10.0),
            const NurseTextField(label: 'Password', isObscured: true),
            const SizedBox(height: 10.0),
            const NurseTextField(label: 'Gender'),
            const SizedBox(height: 10.0),
            const NurseTextField(label: 'Phone'),
            const SizedBox(height: 10.0),
            const NurseTextField(label: 'Email'),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.blue, // Set button background color to blue
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
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

  const NurseTextField({Key? key, required this.label, this.isObscured = false})
      : super(key: key);

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
      style: const TextStyle(color: Colors.white), // Change text color to white
      obscureText: widget.isObscured,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: _isFocused ? '' : widget.label,
        hintStyle: TextStyle(
            color: Colors.white.withOpacity(
                0.7)), // Set placeholder color to white with opacity
        border: InputBorder.none,
      ),
    );
  }
}
