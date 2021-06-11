import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:contact_book_mobile/core/services/config/config.dart';

// All users services are here
class UserServices {
  //################################ POST ################################
  Future<dynamic> login(String email, String password) async {
    var url = Uri.parse(('$path/users/login'));
    print(url);

    String body = '{"email":"$email", "password":"$password"}';

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200 && jsonResponse['status']) {
      return jsonResponse;
    } else {
      print('Error ${response.statusCode}: ${jsonResponse['message']}');
    }

    return jsonResponse;
  }
}
