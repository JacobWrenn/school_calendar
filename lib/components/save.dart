import 'package:apple_eventkit/apple_eventkit.dart';
import 'package:apple_eventkit/models/calendar.dart';
import 'package:flutter/material.dart';

class Save extends StatefulWidget {
  final Function done;
  final bool takeName;

  Save(this.done, this.takeName);

  @override
  _SaveState createState() => _SaveState(done, takeName);
}

class _SaveState extends State<Save> {
  final Function done;
  final controller = TextEditingController();
  final bool takeName;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(Duration(days: 14));
  List<Calendar> calendars = [];
  List<String> calendarSources = [];
  bool saveEnabled = false;
  String calendarSource = "";
  String calendarId = "";
  bool reverse = false;

  _SaveState(this.done, this.takeName);

  @override
  void initState() {
    loadCalendars();
    super.initState();
  }

  void loadCalendars() async {
    calendars = await AppleEventkit().getCalendars();
    calendars.forEach((element) {
      if (!calendarSources.contains(element.account))
        calendarSources.add(element.account);
    });
    calendarSource = calendars[0].account;
    calendarId = calendars[0].id;
    setState(() {
      saveEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Save Timetable"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (takeName) ...[
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Timetable name...",
              ),
            ),
            SizedBox(height: 16),
          ],
          Row(
            children: [
              Text("Start Date"),
              Spacer(),
              TextButton(
                onPressed: () async {
                  start = await showDatePicker(
                        context: context,
                        initialDate: start,
                        firstDate: DateTime.now().subtract(Duration(days: 365)),
                        lastDate: DateTime.now().add(Duration(days: 900)),
                      ) ??
                      start;
                },
                child: Text("Pick Date"),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("End Date"),
              Spacer(),
              TextButton(
                onPressed: () async {
                  end = await showDatePicker(
                        context: context,
                        initialDate: end,
                        firstDate: DateTime.now().subtract(Duration(days: 365)),
                        lastDate: DateTime.now().add(Duration(days: 900)),
                      ) ??
                      end;
                },
                child: Text("Pick Date"),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("Calendar Source"),
              Spacer(),
              SizedBox(width: 16),
              if (saveEnabled)
                DropdownButton(
                  onChanged: (String? value) {
                    setState(() {
                      calendarSource = value ?? calendarSource;
                      calendarId = calendars
                          .where((element) => element.account == calendarSource)
                          .toList()[0]
                          .id;
                    });
                  },
                  value: calendarSource,
                  items: calendarSources
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("Calendar"),
              Spacer(),
              SizedBox(width: 16),
              if (saveEnabled)
                DropdownButton(
                  onChanged: (String? value) {
                    setState(() {
                      calendarId = value ?? calendarId;
                    });
                  },
                  value: calendarId,
                  items: calendars
                      .where((element) => element.account == calendarSource)
                      .map((e) => DropdownMenuItem(
                            child: Text(
                              e.title,
                              style: TextStyle(color: e.color),
                            ),
                            value: e.id,
                          ))
                      .toList(),
                ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("Reverse Week Order"),
              Checkbox(
                value: reverse,
                onChanged: (value) {
                  setState(() {
                    reverse = value ?? true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (saveEnabled)
              ? () {
                  done(controller.text, start, end, calendarId, calendars,
                      reverse);
                }
              : null,
          child: Text("Save"),
        )
      ],
    );
  }
}
