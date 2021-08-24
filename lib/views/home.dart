import 'package:apple_eventkit/apple_eventkit.dart';
import 'package:flutter/material.dart';
import 'package:school_calendar/constants.dart';
import 'package:school_calendar/views/existing.dart';
import 'package:school_calendar/views/new/new.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool calendarAccess = false;
  bool calendarError = false;

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    final bool access = await AppleEventkit().getAccess();
    setState(() {
      if (access) {
        calendarAccess = true;
      } else {
        calendarError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png", height: 200),
            SizedBox(height: 32),
            Text(
              "School Calendar",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 32),
            if (calendarError)
              Text(
                  "Calendar access failed. Please provide access to your calendar in System Preferences then try again."),
            if (calendarAccess)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: button,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Existing();
                          },
                        ),
                      );
                    },
                    child: Text("Existing Timetables"),
                  ),
                  SizedBox(width: 32),
                  TextButton(
                    style: button,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return New();
                          },
                        ),
                      );
                    },
                    child: Text("Create New Timetable"),
                  ),
                ],
              ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
