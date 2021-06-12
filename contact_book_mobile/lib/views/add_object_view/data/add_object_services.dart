import 'package:contact_book_mobile/core/services/api_correios_services.dart';
import 'package:contact_book_mobile/core/services/contact_services.dart';

class AddObjectServices {
  Future<dynamic> createContact(int userId, String token, String body) async {
    return await ContactServices().createContact(userId, token, body);
  }

  Future<dynamic> getAddressByZipCode(String zipCode) async {
    return await ApiCorreiosServices().getAddressByZipCode(zipCode);
  }
}
