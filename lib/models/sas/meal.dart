import 'package:json_annotation/json_annotation.dart';

// TODO: CHECK IF EXPIRED

@JsonSerializable()
class SASMeal {
  SASMeal({
    required this.meal,
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.location,
    required this.imageUrl,
  });

  String meal;
  int id;
  String name;
  double price;
  String type;
  String location;
  String imageUrl;
}
