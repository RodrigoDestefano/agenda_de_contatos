import 'dart:convert' as convert;
import 'dart:convert';
import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/models/group.dart';
import 'package:http/http.dart' as http;
import 'package:contact_book_mobile/core/services/config/config.dart';

//  All group services are here
class GroupServices {
  //################################ GET ################################
  Future<List<Group>> getGroupsByUserId(int? userId, String? token) async {
    List<Group> groups = [];

    var url = Uri.parse(('$path/users/$userId/groups'));
    print(url);

    var response =
        await http.get(url, headers: {"authorization": "Bearer $token"});

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      var decode = json.decode(utf8.decode(response.bodyBytes))['group']
          as List<dynamic>;

      for (var contact in decode) {
        groups.add(Group.fromJson(contact));
      }

      return groups;
    } else {
      print('Error ${response.statusCode}: ${jsonResponse['message']}');
    }

    return groups;
  }

  Future<List<Contact>> getGroup(int? groupId, String? token) async {
    List<Contact> contacts = [];

    var url = Uri.parse(('$path/groups/$groupId'));
    print(url);

    var response =
        await http.get(url, headers: {"authorization": "Bearer $token"});

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    print(jsonResponse);

    if (response.statusCode == 200) {
      var decode = json.decode(utf8.decode(response.bodyBytes))['contacts']
          as List<dynamic>;

      for (var contact in decode) {
        print(contact);
        contacts.add(Contact.fromJson(contact));
      }

      return contacts;
    } else {
      print('Error ${response.statusCode}: ${jsonResponse['message']}');
    }

    return contacts;
  }

  //################################ POST ################################
  Future<dynamic> createGroup(int userId, String token, String body) async {
    var url = Uri.parse(('$path/users/$userId/groups'));
    print(url);

    var response = await http.post(url,
        headers: {
          "authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: body);

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return jsonResponse;
    } else {
      print('Error ${response.statusCode}: ${jsonResponse['message']}');
    }
    return jsonResponse;
  }
}
