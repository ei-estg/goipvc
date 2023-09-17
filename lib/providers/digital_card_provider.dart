import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_card.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';

final digitalCardProvider = FutureProvider<MyIPVCCard>((ref) async {
  return await MyIPVCAPI().getDigitalCard();
});