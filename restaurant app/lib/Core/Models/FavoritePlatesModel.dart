// import 'dart:convert';
//
// class FavoritePlatesResponse {
//   final List<FavoritePlateItem> items;
//
//   FavoritePlatesResponse({required this.items});
//
//   factory FavoritePlatesResponse.fromJson(String source) =>
//       FavoritePlatesResponse.fromMap(json.decode(source));
//
//   factory FavoritePlatesResponse.fromMap(Map<String, dynamic> json) {
//     return FavoritePlatesResponse(
//       items: List<FavoritePlateItem>.from(
//         json['items'].map((x) => FavoritePlateItem.fromMap(x)),
//       ),
//     );
//   }
// }
//
// class FavoritePlateItem {
//   final String id;
//   final List<Plate> plates;
//
//   FavoritePlateItem({
//     required this.id,
//     required this.plates,
//   });
//
//   factory FavoritePlateItem.fromMap(Map<String, dynamic> json) {
//     return FavoritePlateItem(
//       id: json['id'],
//       plates: List<Plate>.from(
//         json['expand']['plates'].map((x) => Plate.fromMap(x)),
//       ),
//     );
//   }
// }
//
// class Plate {
//   final String id;
//   final String name;
//   final String category;
//   final String description;
//   final double price;
//   final String evaluation;
//   final List<String> images;
//   final List<String> ingredients;
//
//   Plate({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.description,
//     required this.price,
//     required this.evaluation,
//     required this.images,
//     required this.ingredients,
//   });
//
//   factory Plate.fromMap(Map<String, dynamic> json) {
//     return Plate(
//       id: json['id'],
//       name: json['name'],
//       category: json['category'],
//       description: json['description'],
//       price: (json['price'] as num).toDouble(),
//       evaluation: json['evaluation'],
//       images: [
//         json['image_url_1'] ?? '',
//         json['image_url_2'] ?? '',
//         json['image_url_3'] ?? '',
//       ],
//       ingredients: List<String>.from(
//         json['expand']['ingredients'].map((x) => x['name']),
//       ),
//     );
//   }
// }
