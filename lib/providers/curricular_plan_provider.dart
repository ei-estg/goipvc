import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/curricular_unit.dart';
import 'package:goipvc/services/myipvc_api.dart';

final curricularPlanProvider = FutureProvider<List<MyIPVCCurricularUnit>>((ref) async {
  return await MyIPVCAPI.getCurricularPlan();
});