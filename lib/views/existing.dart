import 'dart:convert';
import 'dart:io';

import 'package:apple_eventkit/models/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_calendar/components/save.dart';
import 'package:school_calendar/constants.dart';
import 'package:school_calendar/helpers/savecalendar.dart';
import 'package:school_calendar/models/outline.dart';

class Existing extends StatefulWidget {
  const Existing({Key? key}) : super(key: key);

  @override
  _ExistingState createState() => _ExistingState();
}

class _ExistingState extends State<Existing> {
  List<Week> weeks = [];
  bool spinning = false;
  List<Map<String, dynamic>> timetables = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final directory = Directory(path);
    await for (var file in directory.list()) {
      if (file.path.contains(".json")) {
        List jsonList = jsonDecode(await File(file.path).readAsString());
        List<Week> parsedWeeks = [];
        jsonList.forEach((element) {
          parsedWeeks.add(Week.fromJson(element));
        });
        timetables.add({
          'weeks': parsedWeeks,
          'name': file.path.split("/").last.split("###")[0],
          'path': file.path,
        });
      }
    }
    setState(() {});
  }

  Future saveToCalendar(String name, DateTime start, DateTime end,
      String calendarId, List<Calendar> calendars) async {
    setState(() {
      spinning = true;
    });
    await CalendarSaver()
        .save(name, start, end, calendarId, calendars, weeks, false, false);
    setState(() {
      spinning = false;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Save Complete!"),
          content: Text("You can now safely return to the homepage."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (spinning)
            ? SpinKitRing(color: Color.fromRGBO(244, 0, 32, 1))
            : Center(
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Existing Timetables",
                                  style: TextStyle(fontSize: 32))
                            ],
                          ),
                        ),
                        TextButton(
                          style: button,
                          onPressed: () {
                            Navigator.pop(context, weeks);
                          },
                          child: Text("Done"),
                        ),
                        SizedBox(width: 32),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 32, 16, 16),
                        child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 2,
                          children: [
                            for (var timetable in timetables)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(timetable["name"],
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Confirm Deletion"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await File(timetable[
                                                                  'path'])
                                                              .delete();
                                                          setState(() {
                                                            timetables.remove(
                                                                timetable);
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Delete"),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text("Delete"),
                                        ),
                                        SizedBox(width: 16),
                                        TextButton(
                                          style: button,
                                          onPressed: () {
                                            weeks = timetable['weeks'];
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Save(
                                                  (String name,
                                                      DateTime start,
                                                      DateTime end,
                                                      String calendarId,
                                                      List<Calendar> calendars,
                                                      bool reverse) async {
                                                    if (reverse) {
                                                      weeks = weeks.reversed
                                                          .toList();
                                                    }
                                                    Navigator.pop(context);
                                                    saveToCalendar(
                                                        name,
                                                        start,
                                                        end,
                                                        calendarId,
                                                        calendars);
                                                  },
                                                  false,
                                                );
                                              },
                                            );
                                          },
                                          child: Text("Reuse"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
