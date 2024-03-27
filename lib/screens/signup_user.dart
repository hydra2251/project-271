import 'package:flutter/material.dart';
import 'package:project271/screens/login.dart'; // Import LoginPage if not already imported

class SignUpUser extends StatefulWidget {
  const SignUpUser({Key? key}) : super(key: key);

  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  late FocusNode nameFocusNode;
  late FocusNode ageFocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<String> genderOptions = ['Male', 'Female'];
  String? selectedGender; // Change to nullable type

  final String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    ageFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    ageFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 220, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 220, 225),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Client',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10.0),
              Image.asset(
                'lib/assets/nursesicon.png',
                height: 120,
              ),
              const SizedBox(height: 40.0),
              TextFormField(
                style: const TextStyle(color: Colors.blue),
                focusNode: nameFocusNode,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(nameFocusNode);
                  });
                },
                decoration: InputDecoration(
                  labelText: nameFocusNode.hasFocus ? '' : 'Name',
                  labelStyle: const TextStyle(color: Colors.blue),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                style: const TextStyle(color: Colors.blue),
                focusNode: ageFocusNode,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(ageFocusNode);
                  });
                },
                decoration: InputDecoration(
                  labelText: ageFocusNode.hasFocus ? '' : 'Age',
                  labelStyle: const TextStyle(color: Colors.blue),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: const TextStyle(color: Colors.blue),
                  border: InputBorder.none,
                ),
                value: selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
                items: genderOptions.map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(
                      gender,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.blue),
                focusNode: emailFocusNode,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  });
                },
                decoration: InputDecoration(
                  labelText: emailFocusNode.hasFocus ? '' : 'Email',
                  labelStyle: const TextStyle(color: Colors.blue),
                  border: InputBorder.none,
                  errorText: _validateEmail(_emailController.text),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.blue),
                focusNode: passwordFocusNode,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: passwordFocusNode.hasFocus ? '' : 'Password',
                  labelStyle: const TextStyle(color: Colors.blue),
                  border: InputBorder.none,
                  errorText: _validatePassword(_passwordController.text),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add your sign-up logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
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
