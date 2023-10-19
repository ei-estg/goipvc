import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/exam.dart';
import 'package:goipvc/services/myipvc_api.dart';

final examsProvider = FutureProvider<List<MyIPVCExam>>((ref) async {
  return await MyIPVCAPI.getExams();
});