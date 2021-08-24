import 'package:flutter/material.dart';
import 'package:school_calendar/components/fillperiod.dart';
import 'package:school_calendar/constants.dart';
import 'package:school_calendar/models/outline.dart';

class Fill extends StatefulWidget {
  final List<Week> weeks;

  Fill(this.weeks);

  @override
  _FillState createState() => _FillState(weeks);
}

class _FillState extends State<Fill> {
  List<Week> weeks;

  _FillState(this.weeks);

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
                      Text("Fill Content", style: TextStyle(fontSize: 32))
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[350],
                ),
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(8),
                child: ListView(
                  children: [
                    for (var week in weeks) ...[
                      SizedBox(height: 16),
                      Center(
                        child: Text(week.label, style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var day in week.days)
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    (MediaQuery.of(context).size.width - 100) /
                                        5,
                              ),
                              child: Container(
                                margin: (week.days.indexOf(day) == 0)
                                    ? EdgeInsets.fromLTRB(0, 8, 0, 8)
                                    : EdgeInsets.fromLTRB(8, 8, 0, 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[400],
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Text(day.day),
                                      for (var period in day.periods)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          margin:
                                              EdgeInsets.fromLTRB(0, 16, 0, 0),
                                          child: (!period.filled)
                                              ? TextButton(
                                                  child: Container(
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(period.name),
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return FillPeriod(
                                                          (name, location) {
                                                            period.filledName =
                                                                name;
                                                            period.location =
                                                                location;
                                                            setState(() {
                                                              period.filled =
                                                                  true;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                )
                                              : TextButton(
                                                  child: Container(
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                      period.filledName,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    period.filledName = "";
                                                    period.location = "";
                                                    setState(() {
                                                      period.filled = false;
                                                    });
                                                  },
                                                ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
