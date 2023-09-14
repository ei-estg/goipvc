import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Settings {
  Settings({
    required this.theme,
    required this.brightness,
    required this.pictureAlignment,
  });

  String theme;
  String brightness;
  String pictureAlignment;

  Settings copyWith({String? theme, String? brightness, String? pictureAlignment}) {
    return Settings(
      theme: theme ?? this.theme,
      brightness: brightness ?? this.brightness,
      pictureAlignment: pictureAlignment ?? this.pictureAlignment,
    );
  }
}