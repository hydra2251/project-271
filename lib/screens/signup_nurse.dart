import 'package:flutter/material.dart';

class NursePage extends StatefulWidget {
  const NursePage({Key? key}) : super(key: key);

  @override
  _NursePageState createState() => _NursePageState();
}

class _NursePageState extends State<NursePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
          child: Form(
            key: _formKey,
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
                  controller: _fullNameController,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Username',
                  controller: _usernameController,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Password',
                  controller: _passwordController,
                  isObscured: true,
                  isRequired: true,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
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
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      items: ['Male', 'Female']
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                          .toList(),
                      onChanged: (value) {
                        // Handle gender selection
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Gender is required';
                        }
                        return null;
                      },
                      hint: Text(
                        'Gender',
                        style:
                        TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Phone',
                  controller: _phoneController,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                NurseTextField(
                  label: 'Email',
                  controller: _emailController,
                  isRequired: true,
                  isEmail: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
          ),
        ),
      ),
    );
  }
}

class NurseTextField extends StatelessWidget {
  final String label;
  final bool isObscured;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;
  final bool isEmail;
  final FormFieldValidator<String>? validator;

  const NurseTextField({
    Key? key,
    required this.label,
    this.isObscured = false,
    required this.controller,
    this.isPassword = false,
    this.isRequired = false,
    this.isEmail = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: isObscured,
      validator: isRequired ? validator : null,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorStyle: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}