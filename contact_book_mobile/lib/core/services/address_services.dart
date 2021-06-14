import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:contact_book_mobile/core/models/address.dart';
import 'package:contact_book_mobile/core/services/config/config.dart';

// This class contains all Address services used in the app
// They follow as the /contact_book_back_end/src/routes.js file
// Separated by the methods GET, POST, PUT, DELETE
class AddressServices {
  //################################ GET ################################

  // BACK END ROUTE: router.get('/contacts/:contact_id/address', AddressController.getAllAddressByContactId);
  Future<List<Address>> getAllAddressByContactId(
      int? contactId, String? token) async {
    List<Address> address = [];

    var url = Uri.parse(('$path/contacts/$contactId/address'));
    print(url);

    var response =
        await http.get(url, headers: {"authorization": "Bearer $token"});

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      for (var addr in jsonResponse['address']) {
        address.add(Address.fromJson(addr));
      }
      return address;
    } else {
      print('Error ${response.statusCode}: ${jsonResponse['message']}');
    }

    return address;
  }

  //################################ POST ################################

  // BACK END ROUTE: router.post('/contacts/:contact_id/address', AddressController.createAddress);
  Future<dynamic> createAddress(
      int? contactId, String body, String? token) async {
    var url = Uri.parse(('$path/contacts/$contactId/address'));
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

  // BACK END ROUTE: router.delete('/address/:address_id', AddressController.deleteAddress);
  Future<dynamic> deleteAddress(int? addressId, String? token) async {
    var url = Uri.parse(('$path/address/$addressId'));
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
