import 'dart:convert';

import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/models/group.dart';

// Function that converts a json to an User object
User userFromJson(String str) => User.fromJson(json.decode(str));

// Function that converts an User object to json
String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {this.id,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.contact,
      this.group});

  int? id;
  String? name;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;

  // DB Relationship:

  // (User) 1 : N (Contacts)
  List<Contact>? contact;
  // (User) 1 : N (Groups)
  List<Group>? group;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        contact: json["contact"] == null
            ? null
            : List<Contact>.from(
                json["contact"]?.map((x) => Contact.fromJson(x))),
        group: json["group"] == null
            ? null
            : List<Group>.from(json["group"]?.map((x) => Contact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "contact": contact == null
            ? null
            : List<dynamic>.from(contact!.map((x) => x.toJson())),
      };
}
