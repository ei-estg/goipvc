import 'package:intl/intl.dart';
import 'package:goipvc/models/myipvc/lesson.dart';

bool verifyIfLessonExpired(MyIPVCLesson lesson) {
  var dayFormatter = DateFormat('yyyy-MM-dd');
  String currentDate = dayFormatter.format(DateTime.now());
  String lessonDate = dayFormatter.format(DateTime.parse(lesson.dataHoraIni));

  if (lessonDate != currentDate) {
    return true;
  }

  if (DateTime.now().isAfter(DateTime.parse(lesson.dataHoraFim))) {
    return true;
  }

  return false;
}
