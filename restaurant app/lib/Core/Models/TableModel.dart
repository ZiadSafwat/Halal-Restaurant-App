import 'dart:convert';

class TableModel {
  int capacity;
  String collectionId;
  String collectionName;
  DateTime created;
  String id;
  bool isActive;
  String name;
  DateTime updated;
  double xAxis;
  double yAxis;

  TableModel({
    required this.capacity,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.id,
    required this.isActive,
    required this.name,
    required this.updated,
    required this.xAxis,
    required this.yAxis,
  });

  TableModel copyWith({
    int? capacity,
    String? collectionId,
    String? collectionName,
    DateTime? created,
    String? id,
    bool? isActive,
    String? name,
    DateTime? updated,
    double? xAxis,
    double? yAxis,
  }) =>
      TableModel(
        capacity: capacity ?? this.capacity,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        created: created ?? this.created,
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        name: name ?? this.name,
        updated: updated ?? this.updated,
        xAxis: xAxis ?? this.xAxis,
        yAxis: yAxis ?? this.yAxis,
      );

  factory TableModel.fromJson(String str) => TableModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TableModel.fromMap(Map<String, dynamic> json) => TableModel(
    capacity: json["capacity"],
    collectionId: json["collectionId"],
    collectionName: json["collectionName"],
    created: DateTime.parse(json["created"]),
    id: json["id"],
    isActive: json["is_active"],
    name: json["name"],
    updated: DateTime.parse(json["updated"]),
    xAxis: json["x_axis"]?.toDouble(),
    yAxis: json["y_axis"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "capacity": capacity,
    "collectionId": collectionId,
    "collectionName": collectionName,
    "created": created.toIso8601String(),
    "id": id,
    "is_active": isActive,
    "name": name,
    "updated": updated.toIso8601String(),
    "x_axis": xAxis,
    "y_axis": yAxis,
  };
}
