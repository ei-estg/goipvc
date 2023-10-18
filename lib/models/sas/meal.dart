class SASMeal {
  SASMeal({
    required this.meal,
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.location,
    required this.imageUrl,
    required this.available
  });

  String meal;
  int id;
  String name;
  double price;
  String type;
  String location;
  String? imageUrl;
  bool available;
}
