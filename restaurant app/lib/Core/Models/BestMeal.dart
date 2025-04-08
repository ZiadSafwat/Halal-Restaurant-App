import 'dart:convert';

class BestMealModel {
  List<Meal> items;

  BestMealModel({required this.items});

  factory BestMealModel.fromJson(String str) =>
      BestMealModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BestMealModel.fromMap(Map<String, dynamic> json) => BestMealModel(
    items: List<Meal>.from(json["items"].map((x) => Meal.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
  };
}

class Meal {
  String id;
  String mealName;
  String image;
  num price;
  num discountedPrice;
  num discount;
  DateTime discountLastDate;
  String mealDescription;
  List<Plate> plates;

  Meal({
    required this.id,
    required this.mealName,
    required this.image,
    required this.price,
    required this.discountedPrice,
    required this.discount,
    required this.discountLastDate,
    required this.mealDescription,
    required this.plates,
  });

  factory Meal.fromJson(String str) => Meal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meal.fromMap(Map<String, dynamic> json) => Meal(
    id: json["id"],
    mealName: json["meal_name"],
    image: json["image"],
    discount: (json["discount"] as num?) ?? 0,
    discountedPrice: (json["discounted_price"] as num?) ?? 0,
    price: (json["price"] as num?) ?? 0,
    discountLastDate: json["discount_last_date"] != null
        ? DateTime.parse(json["discount_last_date"])
        : DateTime.now(),
    mealDescription: json["meal_description"] ?? "",
    plates:
    List<Plate>.from(json["plates"].map((x) => Plate.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "meal_name": mealName,
    "image": image,
    "price": price,
    "discounted_price": discountedPrice,
    "discount": discount,
    "discount_last_date": discountLastDate.toIso8601String(),
    "meal_description": mealDescription,
    "plates": List<dynamic>.from(plates.map((x) => x.toMap())),
  };
}

class Plate {
  String plateId;
  String plateName;
  String plateDescription;
  num platePrice;
  List<Ingredient> ingredients;

  Plate({
    required this.plateId,
    required this.plateName,
    required this.plateDescription,
    required this.platePrice,
    required this.ingredients,
  });

  factory Plate.fromJson(String str) => Plate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Plate.fromMap(Map<String, dynamic> json) => Plate(
    plateId: json["plate_id"],
    plateName: json["plate_name"],
    plateDescription: json["plate_description"],
    platePrice: (json["plate_price"] as num?) ?? 0,
    ingredients: List<Ingredient>.from(
        json["ingredients"].map((x) => Ingredient.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "plate_id": plateId,
    "plate_name": plateName,
    "plate_description": plateDescription,
    "plate_price": platePrice,
    "ingredients":
    List<dynamic>.from(ingredients.map((x) => x.toMap())),
  };
}

class Ingredient {
  String ingredientId;
  String ingredientName;

  Ingredient({
    required this.ingredientId,
    required this.ingredientName,
  });

  factory Ingredient.fromJson(String str) =>
      Ingredient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
    ingredientId: json["ingredient_id"],
    ingredientName: json["ingredient_name"],
  );

  Map<String, dynamic> toMap() => {
    "ingredient_id": ingredientId,
    "ingredient_name": ingredientName,
  };
}
