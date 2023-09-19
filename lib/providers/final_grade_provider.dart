import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/services/myipvc_api.dart';

final finalGradeProvider = FutureProvider<double>((ref) async {
  return await MyIPVCAPI().getFinalGrade();
});