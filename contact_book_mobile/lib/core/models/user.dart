import 'dart:convert';

import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/models/group.dart';

// The class that models a User object
// All the parameters can be accessed and the toJson() e fromJson() methods
// allows obtaining the object by service requests
//
// For more models formats:
// https://app.quicktype.io/ can be used to convert a json file to a Dart object

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  // User default constructor
  User(
      {this.id,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.contact,
      this.group});

  // All class parameters
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
