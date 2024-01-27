import 'dart:core';

class MyIPVCCalendar {
  String firstSemesterDates;
  String secondSemesterDates;

  String christmasBreak;
  String carnivalBreak;
  String easterBreak;
  String academicWeek;

  List<String> firstSemesterHolidays;
  List<String> secondSemesterHolidays;

  Map<String, String> commemorativeDays;

  String firstSemesterExamDates;
  String secondSemesterExamDates;
  String specialSeasonExamDates;

  MyIPVCCalendar(
      {required this.firstSemesterDates,
      required this.secondSemesterDates,
      required this.christmasBreak,
      required this.carnivalBreak,
      required this.easterBreak,
      required this.academicWeek,
      required this.firstSemesterHolidays,
      required this.secondSemesterHolidays,
      required this.commemorativeDays,
      required this.firstSemesterExamDates,
      required this.secondSemesterExamDates,
      required this.specialSeasonExamDates});
}
