import 'package:intl/intl.dart';
import 'package:goipvc/models/myipvc_lesson.dart';

bool verifyIfLessonExpired(MyIPVCLesson lesson) {
  var dayFormatter = DateFormat('yyyy-MM-dd');
  String currentDate = dayFormatter.format(DateTime.now());
  String lessonDate = dayFormatter.format(DateTime.parse(lesson.data_hora_ini));

  if(lessonDate != currentDate) {
    return true;
  }

  if(DateTime.now().isAfter(DateTime.parse(lesson.data_hora_fim))) {
    return true;
  }

  return false;
}