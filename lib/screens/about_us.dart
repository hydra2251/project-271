import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      backgroundColor: Colors.lightBlue[100], // Set background color here
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Team',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildTeamMember(
                name: 'Batoul Ballout',
                title: 'Frontend Developer',
                imagePath: 'lib/assets/nursesicon.png',
              ),
              _buildTeamMember(
                name: 'Fawaz Nasser',
                title: 'Frontend Developer',
                imagePath: 'lib/assets/nursesicon.png',
              ),
              _buildTeamMember(
                name: 'Theresa Abi Rached',
                title: 'Backend Developer',
                imagePath: 'lib/assets/nursesicon.png',
              ),
              _buildTeamMember(
                name: 'Wael Merhi',
                title: 'Backend developer',
                imagePath: 'lib/assets/nursesicon.png',
              ),
              _buildTeamMember(
                name: 'Wassim Bannout',
                title: 'Frontend developer',
                imagePath: 'lib/assets/nursesicon.png',
              ),
              const SizedBox(height: 24),
              const Text(
                'Our team at HireMyNurse is committed to revolutionizing the healthcare industry by providing cutting-edge solutions that empower nurses and enhance patient care. By leveraging technology, we strive to streamline workflows, improve communication, and ultimately optimize patient outcomes.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String title,
    required String imagePath,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
