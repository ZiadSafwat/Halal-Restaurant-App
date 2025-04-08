import 'dart:convert';

class Plate {
  String plateDescription;
  double platePrice;
  String plateImageUrl1;
  int plateBuyNumber;
  int plateEvaluation;
  String favId;
  bool isFav;
  String plateName;
  List<IngredientsDetail> ingredientsDetails;
  String plateImageUrl2;
  String plateImageUrl3;
  String plateCategory;
  String id;

  Plate({
    required this.plateDescription,
    required this.platePrice,
    required this.plateImageUrl1,
    required this.plateBuyNumber,
    required this.plateEvaluation,
    required this.favId,
    required this.isFav,
    required this.plateName,
    required this.ingredientsDetails,
    required this.plateImageUrl2,
    required this.plateImageUrl3,
    required this.plateCategory,
    required this.id,
  });

  Plate copyWith({
    String? plateDescription,
    double? platePrice,
    String? plateImageUrl1,
    int? plateBuyNumber,
    int? plateEvaluation,
    String? favId,
    bool? isFav,
    String? plateName,
    List<IngredientsDetail>? ingredientsDetails,
    String? plateImageUrl2,
    String? plateImageUrl3,
    String? plateCategory,
    String? id,
  }) =>
      Plate(
        plateDescription: plateDescription ?? this.plateDescription,
        platePrice: platePrice ?? this.platePrice,
        plateImageUrl1: plateImageUrl1 ?? this.plateImageUrl1,
        plateBuyNumber: plateBuyNumber ?? this.plateBuyNumber,
        plateEvaluation: plateEvaluation ?? this.plateEvaluation,
        favId: favId ?? this.favId,
        isFav: isFav ?? this.isFav,
        plateName: plateName ?? this.plateName,
        ingredientsDetails: ingredientsDetails ?? this.ingredientsDetails,
        plateImageUrl2: plateImageUrl2 ?? this.plateImageUrl2,
        plateImageUrl3: plateImageUrl3 ?? this.plateImageUrl3,
        plateCategory: plateCategory ?? this.plateCategory,
        id: id ?? this.id,
      );

  factory Plate.fromJson(String str) => Plate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Plate.fromMap(Map<String, dynamic> json) => Plate(
    plateDescription: json["plate_description"],
    platePrice: json["plate_price"]?.toDouble(),
    plateImageUrl1: json["plate_image_url_1"],
    plateBuyNumber: json["plate_buyNumber"],
    plateEvaluation: json["plate_evaluation"],
    favId: json["fav_id"]!,
    isFav: json["is_fav"],
    plateName: json["plate_name"],
    ingredientsDetails: List<IngredientsDetail>.from(json["ingredients_details"].map((x) => IngredientsDetail.fromMap(x))),
    plateImageUrl2: json["plate_image_url_2"],
    plateImageUrl3: json["plate_image_url_3"],
    plateCategory: json["plate_category"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "plate_description": plateDescription,
    "plate_price": platePrice,
    "plate_image_url_1": plateImageUrl1,
    "plate_buyNumber": plateBuyNumber,
    "plate_evaluation": plateEvaluation,
    "fav_id": favId,
    "is_fav": isFav,
    "plate_name": plateName,
    "ingredients_details": List<dynamic>.from(ingredientsDetails.map((x) => x.toMap())),
    "plate_image_url_2": plateImageUrl2,
    "plate_image_url_3": plateImageUrl3,
    "plate_category": plateCategory,
    "id": id,
  };
}





class IngredientsDetail {
  String ingredientId;
  String ingredientName;

  IngredientsDetail({
    required this.ingredientId,
    required this.ingredientName,
  });

  IngredientsDetail copyWith({
    String? ingredientId,
    String? ingredientName,
  }) =>
      IngredientsDetail(
        ingredientId: ingredientId ?? this.ingredientId,
        ingredientName: ingredientName ?? this.ingredientName,
      );

  factory IngredientsDetail.fromJson(String str) => IngredientsDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IngredientsDetail.fromMap(Map<String, dynamic> json) => IngredientsDetail(
    ingredientId: json["ingredient_id"],
    ingredientName: json["ingredient_name"],
  );

  Map<String, dynamic> toMap() => {
    "ingredient_id": ingredientId,
    "ingredient_name": ingredientName,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
