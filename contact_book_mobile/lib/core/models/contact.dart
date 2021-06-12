import 'dart:convert';

import 'package:contact_book_mobile/core/models/address.dart';
import 'package:contact_book_mobile/core/models/group.dart';

// Function that converts a json to a Contact object
Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

// Function that converts a Contact object to json
String contactToJson(Contact data) => json.encode(data.toJson());

class Contact {
  Contact(
      {this.id,
      this.name = '',
      this.phone,
      this.email,
      this.zipCode,
      this.street,
      this.number,
      this.district,
      this.city,
      this.uf,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.address,
      this.group});

  int? id;
  String name;
  String? phone;
  String? email;
  String? zipCode;
  String? street;
  String? number;
  String? district;
  String? city;
  String? uf;
  DateTime? createdAt;
  DateTime? updatedAt;

  // DB Relationship:

  // (User) 1 : N (Contacts)
  int? userId;
  // (Contact) 1 : N (Addresses)
  List<Address>? address;
  // (Contacts) N : M (Groups)
  List<Group>? group;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        street: json["street"] == null ? null : json["street"],
        number: json["number"] == null ? null : json["number"],
        district: json["district"] == null ? null : json["district"],
        city: json["city"] == null ? null : json["city"],
        uf: json["uf"] == null ? null : json["uf"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["user_id"] == null ? null : json["user_id"],
        address: json["address"] == null
            ? null
            : List<Address>.from(json["address"]?.map((x) => x)),
        group: json["group"] == null
            ? null
            : List<Group>.from(json["group"]?.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "zip_code": zipCode == null ? null : zipCode,
        "street": street == null ? null : street,
        "number": number == null ? null : number,
        "district": district == null ? null : district,
        "city": city == null ? null : city,
        "uf": uf == null ? null : uf,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "user_id": userId == null ? null : userId,
        "address": address == null
            ? null
            : List<dynamic>.from(address!.map((x) => x.toJson())),
        "group": group == null
            ? null
            : List<dynamic>.from(group!.map((x) => x.toJson()))
      };
}
