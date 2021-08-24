import 'package:flutter/material.dart';
import 'package:school_calendar/components/addperiod.dart';
import 'package:school_calendar/components/addweek.dart';
import 'package:school_calendar/constants.dart';
import 'package:school_calendar/models/outline.dart';

class Outline extends StatefulWidget {
  const Outline({Key? key}) : super(key: key);

  @override
  _OutlineState createState() => _OutlineState();
}

class _OutlineState extends State<Outline> {
  List<Week> weeks = [Week("Week A")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 32),
            Row(
              children: [
                SizedBox(width: 32),
                TextButton(
                  style: button,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddWeek((text, copy) {
                          Week newWeek = Week(text);
                          newWeek.days = [];
                          if (copy && weeks.length > 0) {
                            final days = weeks[weeks.length - 1].days;
                            for (var day in days) {
                              Day newDay = Day(day.day);
                              for (var period in day.periods) {
                                Period newPeriod = Period(
                                    period.name, period.start, period.end);
                                newDay.periods.add(newPeriod);
                              }
                              newWeek.days.add(newDay);
                            }
                          }
                          setState(() {
                            weeks.add(newWeek);
                          });
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                  child: Text("Add Week"),
                ),
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
                padding: EdgeInsets.all(16),
                child: ListView(
                  children: [
                    for (var week in weeks) ...[
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(week.label, style: TextStyle(fontSize: 20)),
                          SizedBox(width: 32),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                weeks.remove(week);
                              });
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var day in week.days)
                            Container(
                              margin: EdgeInsets.all(8),
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
                                        padding: EdgeInsets.all(16),
                                        child: Text(period.name),
                                      ),
                                    SizedBox(height: 16),
                                    TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AddPeriod(
                                                (name, start, end) {
                                              setState(() {
                                                day.periods.add(
                                                    Period(name, start, end));
                                              });
                                              Navigator.pop(context);
                                            });
                                          },
                                        );
                                      },
                                      child: Text("Add Period"),
                                    ),
                                    if (week.days.indexOf(day) != 0) ...[
                                      SizedBox(height: 8),
                                      TextButton(
                                        onPressed: () {
                                          final index = week.days.indexOf(day);
                                          setState(() {
                                            List<Period> newPeriods = [];
                                            for (var period in week
                                                .days[index - 1].periods) {
                                              Period newPeriod = Period(
                                                  period.name,
                                                  period.start,
                                                  period.end);
                                              newPeriods.add(newPeriod);
                                            }
                                            day.periods = newPeriods;
                                          });
                                        },
                                        child: Text("Copy Day"),
                                      ),
                                    ]
                                  ],
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
