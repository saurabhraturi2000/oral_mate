import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oral_mate/controller/history_controller.dart';
import 'package:oral_mate/widgets/activity_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryController historyController = Get.find();

  CalendarFormat format = CalendarFormat.week;
  DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();

  Map<String, dynamic>? mySelectedEvents = {};

  final strokesController = TextEditingController();
  final pressureController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    historyController.getActivity();

    loadPreviousEvents();
  }

  loadPreviousEvents() async {
    var myEvents = await historyController.getActivity();

    print(mySelectedEvents);
    setState(() {
      mySelectedEvents = myEvents;
    });
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents?[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents![DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: strokesController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'strokes',
              ),
            ),
            TextField(
              controller: pressureController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'pressure'),
            ),
            TextField(
              controller: timeController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Time'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add Event'),
            onPressed: () {
              if (strokesController.text.isEmpty &&
                  pressureController.text.isEmpty &&
                  timeController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required fields missing'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                print(strokesController.text);
                print(pressureController.text);
                print(timeController.text);

                setState(() {
                  if (mySelectedEvents?[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents?[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "strokes": strokesController.text,
                      "pressure": pressureController.text,
                      "time": timeController.text,
                    });
                  } else {
                    mySelectedEvents?[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "strokes": strokesController.text,
                        "pressure": pressureController.text,
                        "time": timeController.text,
                      }
                    ];
                  }
                });

                print(
                    "New Event for backend developer ${json.encode(mySelectedEvents)}");
                historyController.uploadActivity(mySelectedEvents!);
                strokesController.clear();
                pressureController.clear();
                timeController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    mySelectedEvents?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2020),
              lastDay: DateTime(2040),
              calendarFormat: format,

              //day selected
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDate, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  print(_focusedDay);
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              eventLoader: _listOfDayEvents,

              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              calendarStyle: const CalendarStyle(
                markerDecoration:
                    BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              ),
            ),
            ..._listOfDayEvents(_selectedDate!).map(
              (myEvents) => ActivityWidget(
                strokes: myEvents['strokes'],
                pressure: myEvents['pressure'],
                time: myEvents['time'],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
      ),
    );
  }
}
