import 'dart:convert';

// Function that converts a json to an Address object
Address addressFromJson(String str) => Address.fromJson(json.decode(str));

// Function that converts an Address object to json
String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.id,
    this.phone,
    this.email,
    this.zipCode,
    this.street,
    this.number,
    this.district,
    this.city,
    this.createdAt,
    this.updatedAt,
    this.contactId,
  });

  int? id;
  String? phone;
  String? email;
  String? zipCode;
  String? street;
  String? number;
  String? district;
  String? city;
  DateTime? createdAt;
  DateTime? updatedAt;

  // DB Relationship:

  // (Contact) 1 : N (Addresses)
  int? contactId;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        zipCode: json["zipCode"] == null ? null : json["zip_code"],
        street: json["street"] == null ? null : json["street"],
        number: json["number"] == null ? null : json["number"],
        district: json["district"] == null ? null : json["district"],
        city: json["city"] == null ? null : json["city"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        contactId: json["contact_id"] == null ? null : json["contact_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "zip_code": zipCode == null ? null : zipCode,
        "street": street == null ? null : street,
        "number": number == null ? null : number,
        "district": district == null ? null : district,
        "city": city == null ? null : city,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "contact_id": contactId == null ? null : contactId,
      };
}
