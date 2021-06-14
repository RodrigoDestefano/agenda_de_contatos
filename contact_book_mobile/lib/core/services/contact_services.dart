import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/services/config/config.dart';

// This class contains all Contacts services used in the app
// They follow as the /contact_book_back_end/src/routes.js file
// Separated by the methods GET, POST, PUT, DELETE
class ContactServices {
  //################################ GET ################################

  // BACK END ROUTE: router.get('/users/:user_id/contacts', ContactController.getAllContactsByUserId);
  Future<List<Contact>> getAllContactsByUserId(
      int? userId, String? token) async {
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

  // BACK END ROUTE: router.post('/users/:user_id/contacts', ContactController.createContact);
  Future<dynamic> createContact(int? userId, String body, String? token) async {
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

  // BACK END ROUTE: router.delete('/contacts/:contact_id', ContactController.deleteContact);
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
