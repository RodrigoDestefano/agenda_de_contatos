import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:contact_book_mobile/core/models/group.dart';
import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/services/config/config.dart';

// This class contains all Groups services used in the app
// They follow as the /contact_book_back_end/src/routes.js file
// Separated by the methods GET, POST, PUT, DELETE
class GroupServices {
  //################################ GET ################################

  // BACK END ROUTE: router.get('/groups/:group_id', GroupController.getGroup);
  Future<List<Contact>> getGroup(int? groupId, String? token) async {
    List<Contact> contacts = [];

    var url = Uri.parse(('$path/groups/$groupId'));
    print(url);

    var response =
        await http.get(url, headers: {"authorization": "Bearer $token"});

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      for (var contact in jsonResponse['contacts']) {
        contacts.add(Contact.fromJson(contact));
      }

      return contacts;
    } else {
      print('Error ${response.statusCode}: ${jsonResponse['message']}');
    }

    return contacts;
  }

  // BACK END ROUTE: router.get('/users/:user_id/groups', GroupController.getAllGroupsByUserId);
  Future<List<Group>> getAllGroupsByUserId(int? userId, String? token) async {
    List<Group> groups = [];

    var url = Uri.parse(('$path/users/$userId/groups'));
    print(url);

    var response =
        await http.get(url, headers: {"authorization": "Bearer $token"});

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      for (var contact in jsonResponse['group']) {
        groups.add(Group.fromJson(contact));
      }

      return groups;
    } else {
      print('Error ${response.statusCode}: ${jsonResponse['message']}');
    }

    return groups;
  }

  // This method doesn't exist in routes.js file from the back-end
  // Is used to get all contacts that do not belong to a specific group
  Future<List<Contact>> getMembersOutGroup(
      int? userId, int? groupId, String? token) async {
    List<Contact> contacts = [];
    List<int?> membersId = [];

    var groupMembersUrl = Uri.parse(('$path/groups/$groupId'));
    var allContactsUrl = Uri.parse(('$path/users/$userId/contacts'));

    var groupMembersResponse = await http
        .get(groupMembersUrl, headers: {"authorization": "Bearer $token"});
    var allContactsResponse = await http
        .get(allContactsUrl, headers: {"authorization": "Bearer $token"});

    var groupMembersJson =
        convert.jsonDecode(groupMembersResponse.body) as Map<String, dynamic>;

    var allContactsJson =
        convert.jsonDecode(allContactsResponse.body) as Map<String, dynamic>;

    if (groupMembersResponse.statusCode == 200 &&
        allContactsResponse.statusCode == 200) {
      for (var contact in groupMembersJson['contacts']) {
        membersId.add(Contact.fromJson(contact).id);
      }

      for (var contact in allContactsJson['contact']) {
        if (membersId.contains(Contact.fromJson(contact).id) == false)
          contacts.add(Contact.fromJson(contact));
      }

      return contacts;
    } else {
      print(
          'Error ${groupMembersResponse.statusCode}: ${groupMembersJson['message']}');
      print(
          'Error ${allContactsResponse.statusCode}: ${allContactsJson['message']}');
    }

    return contacts;
  }

  //################################ POST ################################

  // BACK END ROUTE: router.post('/users/:user_id/groups', GroupController.createGroup);
  Future<dynamic> createGroup(int? userId, String body, String? token) async {
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

  // BACK END ROUTE: router.post('/contacts/:contact_id/groups', GroupController.addContactToGroup);
  Future<dynamic> addContactToGroup(
      int? contactId, String? name, String? token) async {
    var url = Uri.parse(('$path/contacts/$contactId/groups'));
    print(url);

    String body = '{"name":"$name"}';

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

  //################################ DELETE ################################

  // BACK END ROUTE: router.delete('/contacts/:contact_id/groups', GroupController.deleteContactFromGroup);
  Future<dynamic> deleteContactFromGroup(
      int? contactId, String? name, String? token) async {
    var url = Uri.parse(('$path/contacts/$contactId/groups'));
    print(url);

    String body = '{"name":"$name"}';

    var response = await http.delete(url,
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

  // BACK END ROUTE: router.delete('/groups/:group_id', GroupController.deleteGroup);
  Future<dynamic> deleteGroup(int? groupId, String? token) async {
    var url = Uri.parse(('$path/groups/$groupId'));
    print(url);

    var response =
        await http.delete(url, headers: {"authorization": "Bearer $token"});

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
