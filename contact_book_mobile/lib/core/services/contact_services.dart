import 'dart:convert' as convert;
import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:http/http.dart' as http;
import 'package:contact_book_mobile/core/services/config/config.dart';

//  All contact services are here
class ContactServices {
  //################################ GET ################################
  Future<List<Contact>> getContactsByUserId(int? userId, String? token) async {
    List<Contact> contacts = [];

    var url = Uri.parse(('$path/users/$userId/contacts'));
    print(url);

    var response =
        await http.get(url, headers: {"authorization": "Bearer $token"});

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      for (var contact in jsonResponse['contact']) {
        contacts.add(Contact.fromJson(contact));
      }

      return contacts;
    } else {
      print('Error ${response.statusCode}: ${jsonResponse['message']}');
    }

    return contacts;
  }

  //################################ POST ################################
  Future<dynamic> createContact(int userId, String token, String body) async {
    var url = Uri.parse(('$path/users/$userId/contacts'));
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

  //################################ DELETE ################################
  Future<dynamic> deleteContact(int? contactId, String? token) async {
    var url = Uri.parse(('$path/contacts/$contactId'));
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
