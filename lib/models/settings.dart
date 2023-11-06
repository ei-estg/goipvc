import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Settings {
  Settings({
    required this.colorScheme,
    required this.theme,
    required this.pictureAlignment,
    required this.lessonAlert
  });

  String colorScheme;
  String theme;
  String pictureAlignment;
  int lessonAlert;

  Settings copyWith({
    String? colorScheme,
    String? theme,
    String? pictureAlignment,
    int? lessonAlert,
  }) {
    return Settings(
      colorScheme: colorScheme ?? this.colorScheme,
      theme: theme ?? this.theme,
      pictureAlignment: pictureAlignment ?? this.pictureAlignment,
      lessonAlert: lessonAlert ?? 0
    );
  }
}