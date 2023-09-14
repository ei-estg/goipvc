import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/picture_alignment_provider.dart';

class ProfilePicture<T> extends ConsumerWidget {
  final String? imageData;
  final double size;

  const ProfilePicture({
    super.key,
    required this.imageData,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (imageData != null){
      var pictureAlignment = ref.watch(pictureAlignmentProvider);
      Uint8List bytes = base64.decode(imageData!);

      return ClipOval(
        child: Image.memory(
          bytes,
          width: size,
          height: size,
          fit: BoxFit.cover,
          alignment: pictureAlignment,
        ),
      );
    } else {
      return ClipOval(
        child: Icon(Icons.account_circle, size: size),
      );
    }
  }
}