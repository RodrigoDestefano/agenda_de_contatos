import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

// This class contains a unique service from https://viacep.com.br/
// It's a free, high-performance webservice to query Brazil Postal Address Codes (ZIP Code)
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
