import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:project271/screens/ClientProfile.dart';
import 'package:project271/screens/about_us.dart';
import 'package:project271/screens/getfilternurse.dart';
import 'package:project271/screens/nurseadvancedinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String username = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final String loadedUsername = await getusername();
    setState(() {
      username = loadedUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hire My Nurse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildWelcomeSection(),
            _buildCategorySection(),
            FutureBuilder<List<dynamic>>(
              future: getnursefilterasync("All", isclientpage: true),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return _buildNursesList(snapshot.data ?? []);
                }
              },
            ),
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

  Widget _buildWelcomeSection() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome!',
            style: TextStyle(fontSize: 24.0),
          ),
          Text(
            username,
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

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
          height: 280.0,
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              _buildCategory('Cardiology',
                  'https://media.istockphoto.com/id/1195893397/vector/cardiologist-listens-to-a-heartbeat-healthy-heart-cardiology.jpg?s=612x612&w=0&k=20&c=F0nchkkQ0yhr4tTQ53HdiHGGpu6gcE-bhp2xBaaCYwY='),
              _buildCategory('Orthopedics',
                  'https://media.istockphoto.com/id/1427353081/vector/nurse-or-physician-helps-patient-with-broken-leg-to-walk-doctor-comforts-injured-person-on.jpg?s=612x612&w=0&k=20&c=N7aK0UQFqzt68ri0N5ZAD21OldVJSPtCkn_oNFLZQso='),
              _buildCategory('Neurology',
                  'https://media.istockphoto.com/id/1094381118/vector/neuroscientists-with-a-giant-chart-of-human-brain-and-a-heart-icon.jpg?s=612x612&w=0&k=20&c=qFBTS7O09utfJ1GnVF26VHsTVG_zQK68PW9p7jIFRQM='),
              _buildCategory('Oncology',
                  'https://media.istockphoto.com/id/1320094034/vector/cancer-therapy-concept-doctor-give-advice-support-motivation-woman-patient-with-cartoon-flat.jpg?s=612x612&w=0&k=20&c=ak0WFPBH8rurbm6mUwS7zQ1DOdeg6hq8hjRdqzuf5Xc='),
              _buildCategory('Pediatrics',
                  'https://static.vecteezy.com/system/resources/previews/002/144/075/original/nurse-helping-sick-child-pediatric-patient-hospital-cartoon-vector.jpg'),
              _buildCategory('Geriatrics',
                  'https://static.vecteezy.com/system/resources/previews/001/830/100/non_2x/grandpa-and-nurse-male-staff-doctors-and-elderly-people-free-vector.jpg')
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 100.0),
              child: Center(
                child: Text(
                  'Available Nurses',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GetNurseFilter(expertise: "All")),
                    ),
                child: const Text(
                  "View all nurses",
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildCategory(String title, String imageURL) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GetNurseFilter(expertise: title)),
        );
      },
      child: Column(
        children: [
          Image.network(
            imageURL,
            height: 100.0,
            width: 100.0,
          ),
          const SizedBox(height: 5.0),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNursesList(List<dynamic> nurses) {
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
                backgroundColor: Colors.grey,
                backgroundImage: nurse['profile'] != null
                    ? MemoryImage(base64Decode(nurse['profile'].toString()))
                    : null,
                child: nurse['profile'] == null
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
              title: Text(
                '${nurse['firstName']} ${nurse['lastName']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Email: ${nurse['email']}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NurseAdvancedInfo(userid: nurse["nurseId"])),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

Future<String> getusername() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("Username") ?? "";
}

String convertimagetobase64(CroppedFile? croppedFile) {
  Uint8List image = File(croppedFile!.path).readAsBytesSync();
  String base64string = base64Encode(image);
  return base64string;
}
