import 'package:flutter/material.dart';

class NursePage extends StatelessWidget {
  const NursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Padding(
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
              NurseTextField(
                label: 'Full Name',
                controller: TextEditingController(),
              ),
              const SizedBox(height: 10.0),
              NurseTextField(
                label: 'Username',
                controller: TextEditingController(),
              ),
              const SizedBox(height: 10.0),
              NurseTextField(
                label: 'Password',
                isObscured: true,
                controller: TextEditingController(),
                isPassword: true,
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.blue,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // Handle gender selection
                    },
                    hint: Text(
                      'Gender',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              NurseTextField(
                label: 'Phone',
                controller: TextEditingController(),
              ),
              const SizedBox(height: 10.0),
              NurseTextField(
                label: 'Email',
                controller: TextEditingController(),
                isEmail: true,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NurseTextField extends StatefulWidget {
  final String label;
  final bool isObscured;
  final TextEditingController controller;
  final bool isPassword;
  final bool isEmail;

  const NurseTextField({
    Key? key,
    required this.label,
    this.isObscured = false,
    required this.controller,
    this.isPassword = false,
    this.isEmail = false,
  }) : super(key: key);

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
      controller: widget.controller,
      style: const TextStyle(color: Colors.white),
      obscureText: widget.isObscured,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: _isFocused ? '' : widget.label,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        border: InputBorder.none,
        errorText: widget.isPassword
            ? _validatePassword(widget.controller.text)
            : widget.isEmail
                ? _validateEmail(widget.controller.text)
                : null,
      ),
    );
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateEmail(String value) {
    final emailPattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Regular expression for email validation
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(emailPattern).hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
}

