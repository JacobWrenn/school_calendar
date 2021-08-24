import 'dart:convert';
import 'dart:io';

import 'package:apple_eventkit/apple_eventkit.dart';
import 'package:apple_eventkit/models/calendar.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_calendar/models/outline.dart';

class CalendarSaver {
  final f = DateFormat("yyyy-MM-dd HH:mm");

  int getWeekday(String day) {
    if (day == "Monday") {
      return 1;
    }
    if (day == "Tuesday") {
      return 2;
    }
    if (day == "Wednesday") {
      return 3;
    }
    if (day == "Thursday") {
      return 4;
    }
    if (day == "Friday") {
      return 5;
    }
    return 0;
  }

  Future save(String name, DateTime start, DateTime end, String calendarId,
      List<Calendar> calendars, List<Week> weeks, bool saveJson) async {
    final directory = await getApplicationDocumentsDirectory();
    final json = jsonEncode(weeks);
    if (saveJson) {
      File('${directory.path}/$name###${DateTime.now().toIso8601String()}.json')
          .writeAsString(json);
    }
    final int interval = weeks.length;
    if (start.weekday > 5) {
      start = start.add(Duration(days: 8 - start.weekday));
    }
    for (var day in weeks[0].days) {
      final weekday = getWeekday(day.day);
      DateTime targetDay;
      if (weekday < start.weekday) {
        targetDay = start
            .add(Duration(days: (7 * interval) - (start.weekday - weekday)));
      } else {
        targetDay = start.add(Duration(days: weekday - start.weekday));
      }
      for (var period in day.periods) {
        await addPeriod(period, targetDay, calendarId, interval, end);
      }
    }
    if (start.weekday > 1) {
      start = start.subtract(Duration(days: start.weekday - 1));
    }
    for (var i = 1; i < weeks.length; i++) {
      for (var day in weeks[i].days) {
        final weekday = getWeekday(day.day);
        DateTime targetDay;
        targetDay =
            start.add(Duration(days: (7 * i) + (weekday - start.weekday)));
        for (var period in day.periods) {
          await addPeriod(period, targetDay, calendarId, interval, end);
        }
      }
    }
  }

  Future addPeriod(Period period, DateTime targetDay, String calendarId,
      int interval, DateTime end) async {
    if (targetDay.hour > period.start.hour) {
      targetDay = targetDay
          .subtract(Duration(hours: targetDay.hour - period.start.hour));
    } else {
      targetDay =
          targetDay.add(Duration(hours: period.start.hour - targetDay.hour));
    }
    if (targetDay.minute > period.start.minute) {
      targetDay = targetDay
          .subtract(Duration(minutes: targetDay.minute - period.start.minute));
    } else {
      targetDay = targetDay
          .add(Duration(minutes: period.start.minute - targetDay.minute));
    }
    DateTime endDate = targetDay;
    if (endDate.hour > period.end.hour) {
      endDate =
          endDate.subtract(Duration(hours: endDate.hour - period.end.hour));
    } else {
      endDate = endDate.add(Duration(hours: period.end.hour - endDate.hour));
    }
    if (endDate.minute > period.end.minute) {
      endDate = endDate
          .subtract(Duration(minutes: endDate.minute - period.end.minute));
    } else {
      endDate =
          endDate.add(Duration(minutes: period.end.minute - endDate.minute));
    }
    await AppleEventkit().createEvent(
        period.filledName,
        f.format(targetDay),
        f.format(endDate),
        calendarId,
        interval.toString(),
        f.format(end),
        period.location);
  }
}
