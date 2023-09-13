import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/models/myipvc_curricular_unit.dart';
import 'package:myipvc_budget_flutter/models/myipvc_detailed_curricular_unit.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';
import 'package:myipvc_budget_flutter/ui/views/error.dart';
import 'package:myipvc_budget_flutter/ui/views/loading.dart';
import 'package:myipvc_budget_flutter/ui/widgets/curricular_unit_info_card.dart';

class CurricularUnitView extends StatelessWidget {
  final MyIPVCCurricularUnit curricularUnit;

  const CurricularUnitView({
    super.key,
    required this.curricularUnit,
  });

  Future<MyIPVCDetailedCurricularUnit> _getDetailedCurricularUnit() async {
    return await MyIPVCAPI().getDetailedCurricularUnit(curricularUnit);
  }

  @override
  Widget build(BuildContext context) {
    if(curricularUnit.TP == "-") {
      curricularUnit.TP = "0.00";
    }

    if(curricularUnit.PL == "-") {
      curricularUnit.PL = "0.00";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Programa"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
            future: _getDetailedCurricularUnit(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Text(
                      curricularUnit.nm_unidade_curricular,
                      style: const TextStyle(
                          fontSize: 24
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "ECTS: ${curricularUnit.ects}",
                        style: const TextStyle(
                            fontSize: 14
                        ),
                        textAlign: TextAlign.center,
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Chip(
                            avatar: const Icon(Icons.schedule),
                            label: Text("TP: ${curricularUnit.TP} horas")
                        ),
                        Chip(
                            avatar: const Icon(Icons.schedule),
                            label: Text("PL: ${curricularUnit.PL} horas")
                        ),
                      ],
                    ),


                    CurricularUnitInfoCard(
                        title: "Responsável",
                        body: Text(snapshot.data!.docentes)
                    ),
                    CurricularUnitInfoCard(
                        title: "Resumo",
                        body: Text(snapshot.data!.resumo)
                    ),
                    CurricularUnitInfoCard(
                        title: "Objetivos da aprendizagem",
                        body: Text(snapshot.data!.objetivos)
                    ),
                    CurricularUnitInfoCard(
                        title: "Conteúdos programáticos",
                        body: Text(snapshot.data!.conteudos)
                    ),
                    CurricularUnitInfoCard(
                        title: "Metodologias de ensino",
                        body: Text(snapshot.data!.metodologias)
                    ),
                    CurricularUnitInfoCard(
                        title: "Avaliação",
                        body: Text(snapshot.data!.avaliacao)
                    ),
                    CurricularUnitInfoCard(
                        title: "Bibliografia principal",
                        body: Text(snapshot.data!.bibliografia_principal)
                    ),
                    CurricularUnitInfoCard(
                        title: "Bibliografia complementar",
                        body: Text(snapshot.data!.bibliografia_complementar)
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return ErrorView(error: snapshot.error.toString());
              }

              return const LoadingView();
            }
        ),
      )
    );
  }
}
