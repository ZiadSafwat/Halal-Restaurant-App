import 'dart:convert';

class BannerModel {
  List<BannerItem> items;

  BannerModel({required this.items});

  factory BannerModel.fromJson(String str) =>
      BannerModel.fromMap(json.decode(str));

  factory BannerModel.fromMap(Map<String, dynamic> json) => BannerModel(
    items: (json["items"] as List?)
        ?.map((x) => BannerItem.fromMap(x))
        .toList() ?? [],
  );

  String toJson() => json.encode({"items": items.map((x) => x.toMap()).toList()});
}

class BannerItem {
  String id;
  String image;
  bool isSlider;
  String link;

  BannerItem({
    required this.id,
    required this.image,
    required this.isSlider,
    required this.link,
  });

  factory BannerItem.fromJson(String str) =>
      BannerItem.fromMap(json.decode(str));

  factory BannerItem.fromMap(Map<String, dynamic> json) => BannerItem(
    id: json["id"] ?? '',
    image: json["image"] ?? '',
    isSlider: json["isSlider"] ?? false,
    link: json["link"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "image": image,
    "isSlider": isSlider,
    "link": link,
  };
}
