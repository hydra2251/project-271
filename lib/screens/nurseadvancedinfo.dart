import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project271/globalvariables.dart';

class NurseAdvancedInfo extends StatefulWidget {
  int userid;
  NurseAdvancedInfo({super.key, required this.userid});

  @override
  State<NurseAdvancedInfo> createState() => _NurseAdvancedInfoState();
}

class _NurseAdvancedInfoState extends State<NurseAdvancedInfo> {
  Map<String, dynamic> userinfo = {};
  List<String> _dates = [];
  @override
  void initState() {
    super.initState();
    loadnurseinfo(widget.userid);
  }

  Future<void> loadnurseinfo(int userid) async {
    Map<String, dynamic> userInformation = await getnurseadvancedinfo(userid);

    setState(() {
      userinfo = userInformation;
      _dates = userInformation["availableDates"] != null &&
              userInformation["availableDates"] != ""
          ? userInformation["availableDates"].toString().split(",").toList()
          : [];
    });
  }

  Future<Map<String, dynamic>> getnurseadvancedinfo(int userid) async {
    try {
      Uri url = Uri.parse(
          "${GlobalVariables.apilink}/User/getnurseadvancedinfo?nurseid=$userid");
      var response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(minutes: 1));

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        return {};
      }
    } on TimeoutException catch (_) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nurse Advanced Info"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                color: const Color(0xFFA4E1FB),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: SizedBox(
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            backgroundImage: userinfo['profilePicture'] != null
                                ? NetworkImage(userinfo['profilePicture']!)
                                : null,
                            child: userinfo['profilePicture'] == null
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 50,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Contact",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1, // Set the thickness of the Divider
                      height:
                          20, // Controls the spacing on top and bottom of the Divider
                    ),
                    const Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userinfo["email"].toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Phone",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 110.0),
                      child: Text(
                        userinfo["phoneNumber"].toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Location",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userinfo["location"].toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Expertise",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userinfo["expertise"].toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Personal Info",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1, // Set the thickness of the Divider
                      height:
                          20, // Controls the spacing on top and bottom of the Divider
                    ),
                    const Text(
                      "Date Of Birth",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: Text(
                        userinfo["dateOfBirth"].toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 90.0),
                      child: Text(
                        "Nationality",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 120.0),
                      child: Text(
                        userinfo["nationality"].toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: const Color(0xFFE9F3F5),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          "${userinfo["firstName"].toString()} ${userinfo["lastName"].toString()}",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Bio : ${userinfo["bio"].toString()}  ',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "More Info",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1, // Set the thickness of the Divider
                        height:
                            20, // Controls the spacing on top and bottom of the Divider
                      ),

                      const Text(
                        "Years of Experience :  ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        userinfo["yearsOfExperience"].toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Hourly Price in USD ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userinfo["hourlyPrice"].toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Daily Price in USD ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userinfo["dailyPrice"].toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Weekly Price in USD",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userinfo["weeklyPrice"].toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Available Dates: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _dates.length,
                          itemBuilder: (context, index) {
                            List<String> dateParts = _dates[index].split('TO');
                            String startDate = dateParts.first.trim();
                            String endDate = dateParts.last.trim();
                            return Card(
                              color: Colors.blue,
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: ListTile(
                                title: const Text("Date Range:"),
                                subtitle: Text(
                                    "Start Date: $startDate\nEnd Date: $endDate"),
                              ),
                            );
                          },
                        ),
                      ),
                      // Add more widgets here for the left column content
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
