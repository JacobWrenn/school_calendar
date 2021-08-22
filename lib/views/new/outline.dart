import 'package:flutter/material.dart';
import 'package:school_calendar/constants.dart';

class Outline extends StatefulWidget {
  const Outline({Key? key}) : super(key: key);

  @override
  _OutlineState createState() => _OutlineState();
}

class _OutlineState extends State<Outline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Outline Timetable", style: TextStyle(fontSize: 32))
                    ],
                  ),
                ),
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
            SizedBox(height: 32),
            Text("Hello"),
          ],
        ),
      ),
    );
  }
}
