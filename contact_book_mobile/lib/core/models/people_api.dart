import 'dart:convert';

// This class models the Google contacts object used in a Google account login
// All the parameters can be accessed and the toJson() e fromJson() methods
// allows obtaining the object by service requests

// The model contains the request body from:
// https://people.googleapis.com/v1/people/me/connections?personFields=names,phoneNumbers

// For others specific models and requests you can access:
// https://developers.google.com/people/api/rest

// And their authorizations in:
// https://developers.google.com/people/api/rest/v1/people/get#authorization-scopes

GoogleContacts googleContactsFromJson(String str) =>
    GoogleContacts.fromJson(json.decode(str));

String googleContactsToJson(GoogleContacts data) => json.encode(data.toJson());

class GoogleContacts {
  GoogleContacts({
    required this.connections,
    required this.nextPageToken,
    required this.totalPeople,
    required this.totalItems,
  });

  List<Connection> connections;
  String nextPageToken;
  int totalPeople;
  int totalItems;

  factory GoogleContacts.fromJson(Map<String, dynamic> json) => GoogleContacts(
        connections: List<Connection>.from(
            json["connections"].map((x) => Connection.fromJson(x))),
        nextPageToken: json["nextPageToken"],
        totalPeople: json["totalPeople"],
        totalItems: json["totalItems"],
      );

  Map<String, dynamic> toJson() => {
        "connections": List<dynamic>.from(connections.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
        "totalPeople": totalPeople,
        "totalItems": totalItems,
      };
}

class Connection {
  Connection({
    required this.resourceName,
    required this.etag,
    required this.names,
    required this.phoneNumbers,
  });

  String resourceName;
  String etag;
  List<Name>? names;
  List<PhoneNumber>? phoneNumbers;

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
        resourceName: json["resourceName"],
        etag: json["etag"],
        names: json["names"] == null
            ? null
            : List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
        phoneNumbers: json["phoneNumbers"] == null
            ? null
            : List<PhoneNumber>.from(
                json["phoneNumbers"].map((x) => PhoneNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resourceName": resourceName,
        "etag": etag,
        "names": names == null
            ? null
            : List<dynamic>.from(names!.map((x) => x.toJson())),
        "phoneNumbers": phoneNumbers == null
            ? null
            : List<dynamic>.from(phoneNumbers!.map((x) => x.toJson())),
      };
}

class Name {
  Name({
    required this.metadata,
    required this.displayName,
    required this.familyName,
    required this.givenName,
    required this.displayNameLastFirst,
    required this.unstructuredName,
    required this.middleName,
  });

  Metadata metadata;
  String displayName;
  String? familyName;
  String givenName;
  String displayNameLastFirst;
  String unstructuredName;
  String? middleName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        metadata: Metadata.fromJson(json["metadata"]),
        displayName: json["displayName"],
        familyName: json["familyName"] == null ? null : json["familyName"],
        givenName: json["givenName"],
        displayNameLastFirst: json["displayNameLastFirst"],
        unstructuredName: json["unstructuredName"],
        middleName: json["middleName"] == null ? null : json["middleName"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "displayName": displayName,
        "familyName": familyName == null ? null : familyName,
        "givenName": givenName,
        "displayNameLastFirst": displayNameLastFirst,
        "unstructuredName": unstructuredName,
        "middleName": middleName == null ? null : middleName,
      };
}

class Metadata {
  Metadata({
    required this.primary,
    required this.source,
  });

  bool? primary;
  Source source;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        primary: json["primary"] == null ? null : json["primary"],
        source: Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary == null ? null : primary,
        "source": source.toJson(),
      };
}

class Source {
  Source({
    required this.type,
    required this.id,
  });

  SourceType? type;
  String id;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        type: sourceTypeValues.map[json["type"]],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": sourceTypeValues.reverse![type],
        "id": id,
      };
}

enum SourceType { CONTACT }

final sourceTypeValues = EnumValues({"CONTACT": SourceType.CONTACT});

class PhoneNumber {
  PhoneNumber({
    required this.metadata,
    required this.value,
    required this.canonicalForm,
    required this.type,
    required this.formattedType,
  });

  Metadata metadata;
  String value;
  String? canonicalForm;
  PhoneNumberType? type;
  FormattedType? formattedType;

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        metadata: Metadata.fromJson(json["metadata"]),
        value: json["value"],
        canonicalForm:
            json["canonicalForm"] == null ? null : json["canonicalForm"],
        type: phoneNumberTypeValues.map[json["type"]],
        formattedType: formattedTypeValues.map[json["formattedType"]],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "value": value,
        "canonicalForm": canonicalForm == null ? null : canonicalForm,
        "type": phoneNumberTypeValues.reverse![type],
        "formattedType": formattedTypeValues.reverse![formattedType],
      };
}

enum FormattedType { MOBILE }

final formattedTypeValues = EnumValues({"Mobile": FormattedType.MOBILE});

enum PhoneNumberType { MOBILE }

final phoneNumberTypeValues = EnumValues({"mobile": PhoneNumberType.MOBILE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
