import 'dart:convert';

class IngredientsModel {
  List<Ingrediant> items;
  int page;
  int totalItems;

  IngredientsModel({
    required this.items,
    required this.page,
    required this.totalItems,
  });

  factory IngredientsModel.fromJson(String str) =>
      IngredientsModel.fromMap(jsonDecode(str));

  String toJson() => jsonEncode(toMap());

  factory IngredientsModel.fromMap(Map<String, dynamic> json) => IngredientsModel(
    items: (json["items"] as List)
        .map((x) => Ingrediant.fromMap(x))
        .toList(),
    page: json["page"],
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toMap() => {
    "items": items.map((x) => x.toMap()).toList(),
    "page": page,
    "totalItems": totalItems,
  };
}

class Ingrediant {
  String id;
  String name;

  Ingrediant({
    required this.id,
    required this.name,
  });

  factory Ingrediant.fromJson(String str) =>
      Ingrediant.fromMap(jsonDecode(str));

  String toJson() => jsonEncode(toMap());

  factory Ingrediant.fromMap(Map<String, dynamic> json) => Ingrediant(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
