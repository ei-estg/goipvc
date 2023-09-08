import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';

final finalGradeProvider = FutureProvider<double>((ref) async {
  return await MyIPVCAPI().getFinalGrade();
});