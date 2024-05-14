import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project271/globalvariables.dart';
import 'package:project271/screens/nurseadvancedinfo.dart';

class GetNurseFilter extends StatefulWidget {
  final String expertise;

  GetNurseFilter({Key? key, required this.expertise}) : super(key: key);

  @override
  State<GetNurseFilter> createState() => _GetNurseFilterState();
}

class _GetNurseFilterState extends State<GetNurseFilter> {
  List<dynamic> _foundUsers = [];
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    // Call the asynchronous operation and update the state when complete
    getnursefilterasync(widget.expertise).then((result) {
      setState(() {
        users = result;
        _foundUsers = result; // Initially display all users
      });
    });
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = users;
    } else {
      results = users
          .where((user) => user["firstName"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Update the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Available Nurse"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: _runFilter,
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _foundUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final nurse = _foundUsers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                    Colors.grey, // Default profile icon color
                                backgroundImage: nurse['profile'] != null
                                    ? NetworkImage(nurse['profile']!)
                                    : null,
                                child: nurse['profile'] == null
                                    ? const Icon(Icons.person,
                                        color: Colors
                                            .white) // Display the icon if profile is null
                                    : null, // If profile is not null, display the image
                              ),
                              title: Text(
                                '${nurse['firstName']} ${nurse['lastName']}',
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
                                      builder: (context) => NurseAdvancedInfo(
                                          userid: nurse["nurseId"])),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> getnursefilterasync(String expertise,
    {bool isclientpage = false}) async {
  try {
    final Uri url = Uri.parse(
        "${GlobalVariables.apilink}/User/getavailableexpertise?expertise=$expertise&Isclientpage=$isclientpage");
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    ).timeout(const Duration(minutes: 1));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      return [];
    }
  } on TimeoutException catch (_) {
    return [];
  }
}
