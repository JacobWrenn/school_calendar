import 'package:flutter/material.dart';

class Period {
  String name;
  TimeOfDay start;
  TimeOfDay end;
  bool filled = false;
  String filledName = "";
  String location = "";

  Period(this.name, this.start, this.end);

  static TimeOfDay parseTime(String time) {
    List<String> split = time.split(":");
    return TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]));
  }

  static String encodeTime(TimeOfDay time) {
    return "${time.hour.toString()}:${time.minute.toString()}";
  }

  Period.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        start = parseTime(json['start']),
        end = parseTime(json['end']),
        filled = json['filled'],
        filledName = json['filledName'],
        location = json['location'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'start': encodeTime(start),
        'end': encodeTime(end),
        'filled': filled,
        'filledName': filledName,
        'location': location,
      };
}

class Day {
  List<Period> periods = [];
  String day;

  Day(this.day);

  static List<Period> parsePeriods(List periods) {
    List<Period> newPeriods = [];
    periods.forEach((element) {
      newPeriods.add(Period.fromJson(element));
    });
    return newPeriods;
  }

  static List encodePeriods(List<Period> periods) {
    List newPeriods = [];
    periods.forEach((element) {
      newPeriods.add(element.toJson());
    });
    return newPeriods;
  }

  Day.fromJson(Map<String, dynamic> json)
      : day = json['day'],
        periods = parsePeriods(json['periods']);

  Map<String, dynamic> toJson() => {
        'day': day,
        'periods': encodePeriods(periods),
      };
}

class Week {
  String label;
  List<Day> days = [];

  Week(this.label)
      : days = [
          Day("Monday"),
          Day("Tuesday"),
          Day("Wednesday"),
          Day("Thursday"),
          Day("Friday"),
        ];

  static List<Day> parseDays(List days) {
    List<Day> newDays = [];
    days.forEach((element) {
      newDays.add(Day.fromJson(element));
    });
    return newDays;
  }

  static List encodeDays(List<Day> days) {
    List newDays = [];
    days.forEach((element) {
      newDays.add(element.toJson());
    });
    return newDays;
  }

  Week.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        days = parseDays(json['days']);

  Map<String, dynamic> toJson() => {
        'label': label,
        'days': encodeDays(days),
      };
}
