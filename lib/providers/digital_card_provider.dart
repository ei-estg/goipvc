import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc_card.dart';
import 'package:goipvc/services/myipvc_api.dart';

final digitalCardProvider = FutureProvider<MyIPVCCard>((ref) async {
  return await MyIPVCAPI().getDigitalCard();
});