import 'dart:convert';

import 'package:contact_book_mobile/core/models/contact.dart';

// The class that models a Group object
// All the parameters can be accessed and the toJson() e fromJson() methods
// allows obtaining the object by service requests
//
// For more models formats:
// https://app.quicktype.io/ can be used to convert a json file to a Dart object

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  // Group default constructor
  Group({
    this.id,
    this.name,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.contact,
  });

  // All class parameters
  int? id;
  String? name;
  DateTime? updatedAt;
  DateTime? createdAt;

  // DB Relationship:

  // (User) 1 : N (Groups)
  int? userId;
  // (Contacts) N : M (Groups)
  List<Contact>? contact;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        userId: json["user_id"] == null ? null : json["user_id"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        contact: json["contact"] == null
            ? null
            : List<Contact>.from(
                json["contact"]?.map((x) => Contact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "user_id": userId == null ? null : userId,
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "contact": contact == null
            ? null
            : List<dynamic>.from(contact!.map((x) => x.toJson())),
      };
}
