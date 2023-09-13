import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_curricular_unit.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';

final curricularPlanProvider = FutureProvider<List<MyIPVCCurricularUnit>>((ref) async {
  return await MyIPVCAPI().getCurricularPlan();
});