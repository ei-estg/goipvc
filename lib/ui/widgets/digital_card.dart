import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_card.dart';

import 'digital_card_container.dart';

class DigitalCard extends ConsumerWidget {
  final MyIPVCCard data;

  const DigitalCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedSide = ref.watch(cardSideProvider);
    Uint8List bytes = base64.decode(
      selectedSide == 0
        ? data.front
        : data.back
    );

    // TODO: Stop card containing this image from flickering
    // when the side is changed

    return Image.memory(
      bytes
    );
  }
}