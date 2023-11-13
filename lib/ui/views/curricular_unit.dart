import 'package:flutter/material.dart';
import 'package:goipvc/models/myipvc/curricular_unit.dart';
import 'package:goipvc/models/myipvc/detailed_curricular_unit.dart';
import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/views/loading.dart';
import 'package:goipvc/ui/widgets/curricular_unit_info_card.dart';
import 'package:tuple/tuple.dart';

final Map<String, String> classType = {
  'P': 'Prática',
  'PL': 'Prática-Laboratorial',
  'T': 'Teórica',
  'TP': 'Teórico-Prática',
};

class CurricularUnitView extends StatelessWidget {
  final MyIPVCCurricularUnit curricularUnit;

  const CurricularUnitView({
    super.key,
    required this.curricularUnit,
  });

  Future<MyIPVCDetailedCurricularUnit> _getDetailedCurricularUnit() async {
    return await MyIPVCAPI.getDetailedCurricularUnit(curricularUnit);
  }

  @override
  Widget build(BuildContext context) {
    var dECTS = double.parse(curricularUnit.ects),
        dP = curricularUnit.p != "" && curricularUnit.p != "-"
            ? double.parse(curricularUnit.p)
            : 0,
        dPL = curricularUnit.pl != "" && curricularUnit.pl != "-"
            ? double.parse(curricularUnit.pl)
            : 0,
        dT = curricularUnit.t != "" && curricularUnit.t != "-"
            ? double.parse(curricularUnit.t)
            : 0,
        dTP = curricularUnit.tp != "" && curricularUnit.tp != "-"
            ? double.parse(curricularUnit.tp)
            : 0;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Programa"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                Text(
                  curricularUnit.nmUnidadeCurricular,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "ECTS: ${dECTS % 1 == 0 ? dECTS.toInt() : dECTS}",
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...[
                      if (dP != 0) Tuple2('P', dP % 1 == 0 ? dP.toInt() : dP),
                      if (dPL != 0)
                        Tuple2('PL', dPL % 1 == 0 ? dPL.toInt() : dPL),
                      if (dT != 0) Tuple2('T', dT % 1 == 0 ? dT.toInt() : dT),
                      if (dTP != 0)
                        Tuple2('TP', dTP % 1 == 0 ? dTP.toInt() : dTP),
                    ].map((tuple) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${classType[tuple.item1]}'),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            },
                            child: Chip(
                              avatar: const Icon(Icons.schedule),
                              label:
                                  Text('${tuple.item1}: ${tuple.item2} horas'),
                            ),
                          ),
                        )),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                FutureBuilder(
                    future: _getDetailedCurricularUnit(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            CurricularUnitInfoCard(
                                title: "Responsável",
                                body: Text(snapshot.data!.docentes)),
                            CurricularUnitInfoCard(
                                title: "Resumo",
                                body: Text(snapshot.data!.resumo)),
                            CurricularUnitInfoCard(
                                title: "Objetivos da aprendizagem",
                                body: Text(snapshot.data!.objetivos)),
                            CurricularUnitInfoCard(
                                title: "Conteúdos programáticos",
                                body: Text(snapshot.data!.conteudos)),
                            CurricularUnitInfoCard(
                                title: "Metodologias de ensino",
                                body: Text(snapshot.data!.metodologias)),
                            CurricularUnitInfoCard(
                                title: "Avaliação",
                                body: Text(snapshot.data!.avaliacao)),
                            CurricularUnitInfoCard(
                                title: "Bibliografia principal",
                                body:
                                    Text(snapshot.data!.bibliografiaPrincipal)),
                            CurricularUnitInfoCard(
                                title: "Bibliografia complementar",
                                body: Text(
                                    snapshot.data!.bibliografiaComplementar))
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return ErrorView(
                          error: snapshot.error.toString(),
                        );
                      }

                      return const LoadingView();
                    })
              ],
            )

            /*FutureBuilder(
              future: _getDetailedCurricularUnit(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return
                } else if (snapshot.hasError) {
                  return ErrorView(error: snapshot.error.toString());
                }

                return const LoadingView();
              }),*/
            ));
  }
}
