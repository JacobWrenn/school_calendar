import 'package:flutter/material.dart';
import 'package:school_calendar/constants.dart';
import 'package:school_calendar/views/new/outline.dart';

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Outline();
                              },
                            ),
                          );
                        },
                        child: Text("Outline Timetable"),
                      ),
                      SizedBox(width: 32),
                      TextButton(
                        style: button,
                        onPressed: () {},
                        child: Text("Fill Content"),
                      ),
                      SizedBox(width: 32),
                      TextButton(
                        style: button,
                        onPressed: () {},
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
