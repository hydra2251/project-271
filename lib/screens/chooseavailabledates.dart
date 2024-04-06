import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:project271/Designs/popupalert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChooseAvailableDates extends StatefulWidget {
  const ChooseAvailableDates({super.key});

  @override
  State<ChooseAvailableDates> createState() => _ChooseAvailableDatesState();
}

class _ChooseAvailableDatesState extends State<ChooseAvailableDates> {
  final TextEditingController _dateController = TextEditingController();
  final List<String> _dates = [];

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
          if (_dates.isNotEmpty)
            Expanded(
                child:
                    TextButton(onPressed: () => {}, child: const Text("Save"))),
        ],
      ),
    );
  }

  void gettime() async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(const Duration(days: 3652)),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(const Duration(days: 3652)),
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
