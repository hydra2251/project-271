import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:project271/Designs/loadingdesign.dart';
import 'package:project271/Designs/popupalert.dart';
import 'package:project271/globalvariables.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseAvailableDates extends StatefulWidget {
  const ChooseAvailableDates({Key? key}) : super(key: key);

  @override
  State<ChooseAvailableDates> createState() => _ChooseAvailableDatesState();
}

class _ChooseAvailableDatesState extends State<ChooseAvailableDates> {
  final TextEditingController _dateController = TextEditingController();
  late List<String> _dates = [];

  @override
  void initState() {
    super.initState();
    _loadAvailableDates();
  }

  Future<void> _loadAvailableDates() async {
    List<String> dates = await getAvailableDates(context);
    setState(() {
      _dates = dates;
    });
  }

  void _addDate() {
    if (_dateController.text.isNotEmpty) {
      setState(() {
        _dates.add(_dateController.text);
        _dateController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Available Dates"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    readOnly: true,
                    onTap: () => gettime(),
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Date Range',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addDate,
                  child: const Text('Add'),
                ),
              ],
            ),
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
                    subtitle:
                        Text("Start Date: $startDate\nEnd Date: $endDate"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _dates.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 200.0),
            child: MaterialButton(
              minWidth: 200, // Adjust the width as needed
              height: 50,
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Adjust the radius as needed
              ),
              onPressed: () => saveAvailableDates(context, _dates),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gettime() async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now().add(const Duration(days: 1)),
      startFirstDate: DateTime.now().add(const Duration(days: 1)),
      startLastDate: DateTime.now().add(const Duration(days: 30)),
      endInitialDate: DateTime.now()
          .add(const Duration(days: 1))
          .add(const Duration(hours: 1)),
      endFirstDate: DateTime.now()
          .add(const Duration(days: 1))
          .add(const Duration(hours: 1)),
      endLastDate: DateTime.now()
          .add(const Duration(days: 30))
          .add(const Duration(hours: 1)),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(maxWidth: 350, maxHeight: 650),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(Tween(begin: 0.0, end: 1.0)),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
    );

    if (dateTimeList != null) {
      DateTime newStart = dateTimeList[0];
      DateTime newEnd = dateTimeList[1];
      if (newEnd.isBefore(newStart)) {
        showalert(context, "Start date is after end date", AlertType.error);
        return;
      }
      bool hasOverlap = false;

      for (String range in _dates) {
        List<String> parts = range.split('TO');
        DateTime start = DateFormat('dd-MM-yyyy hh:mm').parse(parts[0].trim());
        DateTime end = DateFormat('dd-MM-yyyy hh:mm').parse(parts[1].trim());

        if ((start.isBefore(newEnd) || start.isAtSameMomentAs(newEnd)) &&
            (newStart.isBefore(end) || newStart.isAtSameMomentAs(end))) {
          hasOverlap = true;
          break;
        }
      }

      if (!hasOverlap) {
        setState(() {
          _dateController.text =
              "${DateFormat('dd-MM-yyyy hh:mm').format(newStart)} TO ${DateFormat('dd-MM-yyyy hh:mm').format(newEnd)}";
        });
      } else {
        showalert(context, "Date Overlap", AlertType.error);
        setState(() {
          _dateController.clear();
        });
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}

Future<void> saveAvailableDates(
  BuildContext context,
  List<String> dates,
) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showLoadingDialog(context, true);
    Uri url = Uri.parse("${GlobalVariables.apilink}/User/saveavailabledates");
    int? userId = int.tryParse(prefs.getString("UserId") ?? '');
    Map<String, dynamic> userData = {
      "NurseId": userId,
      "AvailableDates": dates.isNotEmpty ? dates.join(",") : "",
    };
    Response response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    ).timeout(const Duration(minutes: 1));

    if (response.statusCode == 200) {
      Navigator.of(context, rootNavigator: true).pop();
      showalert(context, "Dates Saved Successfully", AlertType.success);
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      String error = response.body;
      showalert(context, error, AlertType.warning);
    }
  } on TimeoutException catch (_) {
    Navigator.of(context, rootNavigator: true).pop();
    showalert(
        context, "The request timed out. Please try again.", AlertType.error);
  } catch (e) {
    Navigator.of(context, rootNavigator: true).pop();
    print(e);
    showalert(context, "Application Encountered an Unhandled Exception",
        AlertType.error);
  }
}

Future<List<String>> getAvailableDates(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("UserId");
    int? id = int.tryParse(userId ?? '');
    if (id != null) {
      Uri url = Uri.parse(
          "${GlobalVariables.apilink}/User/getavailabledates?nurseid=$id");
      Response response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        List<dynamic> responseBody = jsonDecode(response.body);
        List<String> dates = responseBody.cast<String>();
        return dates;
      }
    }
    return [];
  } on TimeoutException catch (_) {
    return [];
  } catch (e) {
    print(e);
    return [];
  }
}
