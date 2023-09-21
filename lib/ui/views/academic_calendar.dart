import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class AcademicCalendarView extends StatelessWidget {
  const AcademicCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: const AssetImage("assets/calendar.png"));
  }
}