import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project271/globalvariables.dart';

class GetNurseFilter extends StatefulWidget {
  final String? expertise;

  GetNurseFilter({Key? key, this.expertise}) : super(key: key);

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
    getusersasync(widget.expertise).then((result) {
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
          .where((user) => user["firstname"]
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
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.blue,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(
                            _foundUsers[index]["firstname"],
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            _foundUsers[index]["lastname"],
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
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

Future<List<dynamic>> getusersasync(String? expertise) async {
  try {
    final Uri url = Uri.parse(
        "${GlobalVariables.apilink}/User/getavailableexpertise?expertise=$expertise");
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
