import 'package:json_annotation/json_annotation.dart';

part 'myipvc_card.g.dart';

@JsonSerializable()
class MyIPVCCard {
  MyIPVCCard({
    required this.front,
    required this.back,
  });

  String front;
  String back;


  factory MyIPVCCard.fromJson(Map<String, dynamic> json) => _$MyIPVCCardFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCCardToJson(this);
}