import 'dart:collection';

final Map<String, String> _colorMap = HashMap.from({
  "#cccccc": "Por lecionar/Não elaborado",
  "#78a3ce": "Por lecionar/Elaborado",
  "#f8ddb4": "Lecionada/Não elaborado",
  "#b3ddbf": "Lecionada/Elaborado",
  "#4bb341": "Lecionada/Publicado",
  "#f0a0a0": "Não Lecionada/Anulado",
  "#ff0000": "Anulada/Anulado",
  "#7f5555": "Substituida/Anulado",
  "#f09C01": "Justificada/Anulado",
  "#f05601": "Não Justificada/Anulado",
  "#1f1f1f": "Preparação de Aula",
  "#d9ad29": "Sem estado (erro)",
});

String getStatusFromColor(String color) {
  print(color);

  return _colorMap[color.toLowerCase()] ?? "Desconhecido";
}