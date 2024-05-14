import 'package:flutter/material.dart';
import 'package:project271/screens/ClientPage.dart';
import 'package:project271/screens/advancedsignup.dart';
import 'package:project271/screens/chooseavailabledates.dart';
import 'package:project271/screens/nurseadvancedinfo.dart'; // Ensure this import is correct
import 'package:project271/screens/about_us.dart';
import 'package:project271/screens/ClientProfile.dart'; // Import the About Us screen

class NurseHomePage extends StatefulWidget {
  const NurseHomePage({Key? key}) : super(key: key);

  @override
  State<NurseHomePage> createState() => _NurseHomePageState();
}

class _NurseHomePageState extends State<NurseHomePage> {
  String username = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadusername();
  }

  Future<void> loadusername() async {
    username = await getusername();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Color.fromRGBO(27, 149, 187, 1.0),
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome!',
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontFamily: 'Jomolhari'),
                ),
                Text(
                  username,
                  style: const TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontFamily: 'Jomolhari'),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Image.network(
            'https://media.istockphoto.com/id/1347476924/vector/group-of-doctors-and-nurses-standing-together-in-different-poses.jpg?s=612x612&w=0&k=20&c=X1kFSEBlqPI9Zb0O51GxMqgirNi9gRutsrOt8ZN3yFs=',
            width: 315,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChooseAvailableDates()),
              );
            },
            child: const Text('Choose Available Dates',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Jomolhari',
                )),
          ),
          SizedBox(height: 28),
          Image.network(
            'https://media.istockphoto.com/id/1328668136/video/heartbeat-line-heart-pulse-ecg-beat-rhytm-graph-animation-cardio-animated-video.jpg?s=640x640&k=20&c=t7fYMeSS-0EqmzO9ePni0vD8ft7LOP5Eck3cIMAiDKw=',
            width: 344,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdvancedSignUpPage()),
              );
            },
            child: const Text('Please Enter Your Advanced Sign In Info',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Jomolhari',
                )),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(27, 149, 187, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClientProfile()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
