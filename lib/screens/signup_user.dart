import 'package:flutter/material.dart';
import 'package:project271/screens/login.dart';

class SignUpUser extends StatefulWidget {
  const SignUpUser({Key? key}) : super(key: key);

  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<String> genderOptions = ['Male', 'Female'];
  String? selectedGender;

  final _formKey = GlobalKey<FormState>();
  bool _emailFieldTouched = false;
  bool _passwordFieldTouched = false;

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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Client',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 150.0,
                    child: Image.asset(
                      'lib/assets/nursesicon.png',
                      height: 64, // Adjust the height here
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _ageController,
                  style: const TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: const TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age isrequired';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: const TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.blue),
                      borderRadius:
                      BorderRadius.circular(5.0),
                    ),
                  ),
                  value: selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                  dropdownColor:
                  const Color.fromARGB(255, 200, 220, 225),
                  items:
                  genderOptions.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(
                        gender,
                        style:
                        const TextStyle(color: Colors.blue),
                      ),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gender is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                    const TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.blue),
                      borderRadius:
                      BorderRadius.circular(5.0),
                    ),
                    errorText:
                    _emailFieldTouched
                        ? _validateEmail(_emailController.text)
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      _emailFieldTouched = true;
                      return 'Email is required';
                    } else if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _passwordController,
                  style: const TextStyle(color: Colors.blue),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                    const TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.blue),
                      borderRadius:
                      BorderRadius.circular(5.0),
                    ),
                    errorText:
                    _passwordFieldTouched
                        ? _validatePassword(_passwordController.text)
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      _passwordFieldTouched = true;
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _emailFieldTouched = true;
                    _passwordFieldTouched = true;
                    if (_formKey.currentState!.validate()) {
                      // Handle sign-up logic
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                    const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12),
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                           LoginPage()),
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
      ),
    );
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}