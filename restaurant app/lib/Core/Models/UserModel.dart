import 'dart:convert';

class UserModel {
  String avatar;
  String collectionId;
  String collectionName;
  DateTime created;
  String email;
  bool emailVisibility;
  String gender;
  String id;
  String name;
  DateTime updated;
  String username;
  bool verified;

  UserModel({
    required this.avatar,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.email,
    required this.emailVisibility,
    required this.gender,
    required this.id,
    required this.name,
    required this.updated,
    required this.username,
    required this.verified,
  });

  UserModel copyWith({
    String? avatar,
    String? collectionId,
    String? collectionName,
    DateTime? created,
    String? email,
    bool? emailVisibility,
    String? gender,
    String? id,
    String? name,
    DateTime? updated,
    String? username,
    bool? verified,
  }) =>
      UserModel(
        avatar: avatar ?? this.avatar,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        created: created ?? this.created,
        email: email ?? this.email,
        emailVisibility: emailVisibility ?? this.emailVisibility,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        name: name ?? this.name,
        updated: updated ?? this.updated,
        username: username ?? this.username,
        verified: verified ?? this.verified,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    avatar: json["avatar"],
    collectionId: json["collectionId"],
    collectionName: json["collectionName"],
    created: DateTime.parse(json["created"]),
    email: json["email"],
    emailVisibility: json["emailVisibility"],
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    updated: DateTime.parse(json["updated"]),
    username: json["username"],
    verified: json["verified"],
  );

  Map<String, dynamic> toMap() => {
    "avatar": avatar,
    "collectionId": collectionId,
    "collectionName": collectionName,
    "created": created.toIso8601String(),
    "email": email,
    "emailVisibility": emailVisibility,
    "gender": gender,
    "id": id,
    "name": name,
    "updated": updated.toIso8601String(),
    "username": username,
    "verified": verified,
  };
}
