import 'package:flutter/material.dart';
import 'profile_screen_nurse.dart';
import 'profile_screen_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 220, 225),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'lib/assets/nursesicon.png',
                height: 200,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String username = usernameController.text;
                  String password = passwordController.text;

                  // Call your authentication API here, passing username and password
                  // Example:
                  bool loginSuccess =
                      await authenticateUser(username, password);

                  if (loginSuccess) {
                    // Assuming you receive user type information from the server
                    String userType = await getUserType(
                        username); // Fetch user type from backend

                    if (userType == 'nurse') {
                      // Navigate to nurse profile screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreenNurse()),
                      );
                    } else {
                      // Navigate to regular user profile screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreenUser()),
                      );
                    }
                  } else {
                    // Show error message or handle failed login
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Add your navigation logic for the forgot password page
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to authenticate user with username and password
  Future<bool> authenticateUser(String username, String password) async {
    // Replace this with your authentication logic, e.g., calling an API
    // Example:
    // bool loginSuccess = await yourAuthService.login(username, password);
    bool loginSuccess = true; // Placeholder, replace with actual logic
    return loginSuccess;
  }

  // Function to get the user type (nurse or user) from the backend
  Future<String> getUserType(String username) async {
    // Replace this with your logic to fetch user type from backend
    // Example:
    // String userType = await yourBackendService.getUserType(username);
    String userType = 'user'; // Placeholder, replace with actual logic
    return userType;
  }
}

