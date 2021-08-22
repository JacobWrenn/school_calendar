class Period {
  String start;
  String end;

  Period(this.start, this.end);
}

class Day {
  List<Period> periods = [];
  String day;

  Day(this.day);
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
}
