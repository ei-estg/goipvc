import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/calendar.dart';
import 'package:goipvc/services/myipvc_api.dart';

final calendarProvider = FutureProvider<MyIPVCCalendar>((ref) async {
  return await MyIPVCAPI.getCalendar();
});