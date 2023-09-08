import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';
import '../models/myipvc_grade.dart';

final gradesProvider = FutureProvider<List<MyIPVCGrade>>((ref) async {
  return await MyIPVCAPI().getGrades();
});