import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project271/globalvariables.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<dynamic> _foundUsers = [];
  List<dynamic> users = [];
  bool? isbannedFilter;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _loadAndFilterUsers(isbannedFilter, _searchKeyword);
  }

  Future<void> _loadAndFilterUsers(bool? isbanned, String keyword) async {
    final loadedUsers = await getusersasync(isbanned);
    setState(() {
      users = loadedUsers;
      _applyTextFilter(keyword);
    });
  }

  void _applyTextFilter(String keyword) {
    List<dynamic> results;
    if (keyword.isEmpty) {
      results = users;
    } else {
      results = users
          .where((user) =>
              user["username"].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    _foundUsers = results;
  }

  void _runFilter(String enteredKeyword) {
    setState(() {
      _searchKeyword = enteredKeyword;
      _applyTextFilter(enteredKeyword);
    });
  }

  Future<void> _toggleBanStatus(int userId, bool isBanned) async {
    final Uri url = Uri.parse(
        "${GlobalVariables.apilink}/User/BanUsers?id=$userId&IsBanned=${!isBanned}");
    final http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      _loadAndFilterUsers(isbannedFilter, _searchKeyword);
    }
  }

  Future<void> _changeUserRole(int userId, int roleId) async {
    final Uri url = Uri.parse(
        "${GlobalVariables.apilink}/User/changeUserRole?id=$userId&RoleId=$roleId");
    final http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      _loadAndFilterUsers(isbannedFilter, _searchKeyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Banned'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Not Banned'),
                ),
              ],
              isSelected: [isbannedFilter == true, isbannedFilter == false],
              onPressed: (int index) {
                setState(() {
                  if (index == 0) {
                    isbannedFilter = isbannedFilter == true ? null : true;
                  } else {
                    isbannedFilter = isbannedFilter == false ? null : false;
                  }
                  _loadAndFilterUsers(isbannedFilter, _searchKeyword);
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.blue,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ID: " +
                                        _foundUsers[index]["id"].toString(),
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Username: " +
                                        _foundUsers[index]["username"],
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "First Name: " +
                                        _foundUsers[index]["firstName"]
                                            .toString(),
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Last Name: " +
                                        _foundUsers[index]["lastName"],
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const Divider(color: Colors.grey),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: _foundUsers[index]
                                                  ["isBanned"]
                                              ? MaterialStateProperty.all<
                                                  Color>(Colors.red)
                                              : MaterialStateProperty.all<
                                                      Color>(
                                                  const Color.fromARGB(
                                                      255, 2, 140, 253)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          _toggleBanStatus(
                                            _foundUsers[index]["id"],
                                            _foundUsers[index]["isBanned"],
                                          );
                                        },
                                        child: Text(
                                          _foundUsers[index]["isBanned"]
                                              ? "Unban"
                                              : "Ban",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 2, 140, 253)),
                                        child: DropdownButton<int>(
                                          value: _foundUsers[index]["roleId"],
                                          onChanged: (int? newValue) {
                                            if (newValue != null) {
                                              _changeUserRole(
                                                _foundUsers[index]["id"],
                                                newValue,
                                              );
                                            }
                                          },
                                          items: const [
                                            DropdownMenuItem<int>(
                                              value: 0,
                                              child: Text('Admin'),
                                            ),
                                            DropdownMenuItem<int>(
                                              value: 1,
                                              child: Text('Client'),
                                            ),
                                            DropdownMenuItem<int>(
                                              value: 2,
                                              child: Text('Nurse'),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
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

Future<List<dynamic>> getusersasync(bool? isbanned) async {
  try {
    final Uri url = Uri.parse(
        "${GlobalVariables.apilink}/User/getusers?IsBanned=$isbanned");
    final http.Response response = await http.get(
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
