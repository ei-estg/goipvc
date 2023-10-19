import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/services/myipvc_api.dart';
import '../models/myipvc/grade.dart';

final gradesProvider = FutureProvider<List<MyIPVCGrade>>((ref) async {
  return await MyIPVCAPI.getGrades();
});