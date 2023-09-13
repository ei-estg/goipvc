import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/models/myipvc_curricular_unit.dart';
import 'package:myipvc_budget_flutter/ui/views/curricular_unit.dart';

class CurricularUnitButton<T> extends StatelessWidget {
  final MyIPVCCurricularUnit curricularUnit;

  const CurricularUnitButton({
    super.key,
    required this.curricularUnit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(Icons.arrow_forward),
      title: Text(
        curricularUnit.nm_unidade_curricular,
        overflow: TextOverflow.ellipsis
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CurricularUnitView(
                curricularUnit: curricularUnit
            ))
        );
      },
    );
  }
}