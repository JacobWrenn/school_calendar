import 'package:apple_eventkit/models/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:school_calendar/components/save.dart';
import 'package:school_calendar/constants.dart';
import 'package:school_calendar/helpers/savecalendar.dart';
import 'package:school_calendar/models/outline.dart';
import 'package:school_calendar/views/new/fill.dart';
import 'package:school_calendar/views/new/outline.dart';

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  List<Week> weeks = [];
  bool spinning = false;

  Future saveToCalendar(String name, DateTime start, DateTime end,
      String calendarId, List<Calendar> calendars, bool reverse) async {
    setState(() {
      spinning = true;
    });
    await CalendarSaver()
        .save(name, start, end, calendarId, calendars, weeks, true, reverse);
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
            : Column(
                children: [
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        style: button,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Done"),
                      ),
                      SizedBox(width: 32),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New Timetable",
                          style: TextStyle(fontSize: 32),
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: button,
                              onPressed: () async {
                                weeks = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Outline();
                                    },
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Outline Completed!"),
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
                              },
                              child: Text("Outline Timetable"),
                            ),
                            SizedBox(width: 32),
                            TextButton(
                              style: button,
                              onPressed: () async {
                                weeks = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Fill(weeks);
                                    },
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Content Completed!"),
                                      content: Text(
                                          "You're all ready to save into your calendar."),
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
                              },
                              child: Text("Fill Content"),
                            ),
                            SizedBox(width: 32),
                            TextButton(
                              style: button,
                              onPressed: () {
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
                                        Navigator.pop(context);
                                        saveToCalendar(name, start, end,
                                            calendarId, calendars, reverse);
                                      },
                                      true,
                                    );
                                  },
                                );
                              },
                              child: Text("Save and Add to Calendar"),
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
