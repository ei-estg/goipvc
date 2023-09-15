import 'package:flutter/material.dart';

class CurricularUnitInfoCard<T> extends StatelessWidget {
  final String title;
  final Widget body;

  const CurricularUnitInfoCard({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: body,
            )
          ],
        ),
      )
    );
  }
}