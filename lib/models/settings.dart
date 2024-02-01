class Settings {
  Settings({
    required this.colorScheme,
    required this.theme,
    required this.pictureAlignment,
    required this.lessonAlert,
    required this.showWeekend
  });

  String colorScheme;
  String theme;
  String pictureAlignment;
  int lessonAlert;
  bool showWeekend;

  Settings copyWith({
    String? colorScheme,
    String? theme,
    String? pictureAlignment,
    int? lessonAlert,
    bool? showWeekend
  }) {
    return Settings(
      colorScheme: colorScheme ?? this.colorScheme,
      theme: theme ?? this.theme,
      pictureAlignment: pictureAlignment ?? this.pictureAlignment,
      lessonAlert: lessonAlert ?? 0,
      showWeekend: showWeekend ?? false
    );
  }
}