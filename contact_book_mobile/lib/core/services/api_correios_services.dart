import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiCorreiosServices {
  Future<dynamic> getAddressByZipCode(String zipCode) async {
    try {
      var url = Uri.parse(('https://viacep.com.br/ws/$zipCode/json/'));
      print(url);

      var response = await http.get(url);

      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      return jsonResponse;
    } catch (error) {
      print(error);
    }

    return null;
  }
}
