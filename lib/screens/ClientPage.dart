import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project271/screens/ClientProfile.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hire My Nurse'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildWelcomeSection(), // Welcome section
            _buildCategorySection(), // Category section
            _buildNursesList(), // Available nurses list
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Navigate to home page
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Navigate to nurse profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientProfile()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.view_list),
              onPressed: () {
                // Navigate to view list page
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the welcome section
  Widget _buildWelcomeSection() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(20.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome!',
            style: TextStyle(fontSize: 24.0),
          ),
          Text(
            'Username',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  // Widget for the category section
  Widget _buildCategorySection() {
    return Column(
      children: [
       const SizedBox(height: 10.0),
       const Center(
          child: Text(
            'Category',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 280.0, // Adjust the height as needed
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              _buildCategory('Cardiology', 'lib/assets/nursesicon.png'),
              _buildCategory('Orthopedics', 'lib/assets/nursesicon.png'),
              _buildCategory('Neurology', 'lib/assets/nursesicon.png'),
              _buildCategory('Oncology', 'lib/assets/nursesicon.png'),
              _buildCategory('Pediatrics', 'lib/assets/nursesicon.png'),
              _buildCategory('Geriatrics', 'lib/assets/nursesicon.png'),
            ],
          ),
        ),
       const SizedBox(height: 10.0),
        const Center(
          child: Text(
            'Available Nurses',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  // Widget for individual category
  Widget _buildCategory(String title, String imagePath) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 100.0,
          width: 100.0,
        ),
        const SizedBox(height: 5.0),
        Text(
          title,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Widget for the list of nurses
  Widget _buildNursesList() {
    // List of nurses with provided fields
    List<Map<String, dynamic>> nurses = [
      {
        "nurseId": 1,
        "phoneNumber": "81770426",
        "email": "wael_merhi02@hotmail.com",
        "firstname": "Wael",
        "lastname": "Merhi",
        "expertise": "Cardiology",
        "location": "waaehu",
        "profile": null, // Null profile, will display default profile image
      },
      {
        "nurseId": 2,
        "phoneNumber": "123770426",
        "email": "abcd@gmail.com",
        "firstname": "Wassim",
        "lastname": "Bannout",
        "expertise": "Orthopedics",
        "location": "wjahaj",
        "profile": "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==", // Base64 profile image string
      },
      {
        "nurseId": 3,
        "phoneNumber": "66134556",
        "email": "def@hotmail.com",
        "firstname": "Don",
        "lastname": "Nod",
        "expertise": "Neurology",
        "location": "waaehu",
        "profile": null, // Null profile, will display default profile image
      },
      // Add more nurses as needed
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: nurses.length,
      itemBuilder: (BuildContext context, int index) {
        final nurse = nurses[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey, // Default profile icon color
              backgroundImage: nurse['profile'] != null
                  ? MemoryImage(
                      base64Decode(nurse['profile'].toString()),
                    )
                  : null,
              child: nurse['profile'] == null
                  ? const Icon(Icons.person, color: Colors.white) // Display the icon if profile is null
                  : null, // If profile is not null, display the image
            ),

              title: Text(
                '${nurse['firstname']} ${nurse['lastname']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const SizedBox(height: 8.0),
                  Text(
                    'Expertise: ${nurse['expertise']}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Location: ${nurse['location']}',
                    style: const TextStyle(fontSize: 14),
                  ),
                 const SizedBox(height: 4.0),
                  Text(
                    'Phone Number: ${nurse['phoneNumber']}',
                    style:const TextStyle(fontSize: 14),
                  ),
                 const SizedBox(height: 4.0),
                  Text(
                    'Email: ${nurse['email']}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              onTap: () {
                // Navigate to nurse details page
              },
            ),
          ),
        );
      },
    );
  }
}
