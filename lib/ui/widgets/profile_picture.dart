import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ProfilePicture<T> extends StatelessWidget {
  final String? imageData;
  final double size;

  const ProfilePicture({
    super.key,
    required this.imageData,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (imageData != null){
      Uint8List bytes = base64.decode(imageData!);

      return ClipOval(
        child: Image.memory(
          bytes,
          width: size,
          height: size,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      );
    } else {
      return ClipOval(
        child: Icon(Icons.account_circle, size: size),
      );
    }
  }
}