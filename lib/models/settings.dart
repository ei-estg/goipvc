import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Settings {
  Settings({
    required this.colorScheme,
    required this.theme,
    required this.pictureAlignment,
  });

  String colorScheme;
  String theme;
  String pictureAlignment;

  Settings copyWith({String? colorScheme, String? theme, String? pictureAlignment}) {
    return Settings(
      colorScheme: colorScheme ?? this.colorScheme,
      theme: theme ?? this.theme,
      pictureAlignment: pictureAlignment ?? this.pictureAlignment,
    );
  }
}