import 'dart:convert' as convert;
import 'package:contact_book_mobile/core/models/address.dart';
import 'package:http/http.dart' as http;
import 'package:contact_book_mobile/core/services/config/config.dart';

//  All contact services are here
class AddressServices {
  //################################ GET ################################
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
  Future<dynamic> createAddress(
      int? contactId, String token, String body) async {
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