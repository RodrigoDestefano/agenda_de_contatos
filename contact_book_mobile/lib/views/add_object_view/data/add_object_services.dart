import 'package:contact_book_mobile/core/services/address_services.dart';
import 'package:contact_book_mobile/core/services/api_correios_services.dart';
import 'package:contact_book_mobile/core/services/contact_services.dart';

// This file contains just the services calls used in AddObjectView main page and their widgets
class AddObjectServices {
  Future<dynamic> createContact(int? userId, String body, String? token) async {
    return await ContactServices().createContact(userId, body, token);
  }

  Future<dynamic> createAddress(
      int? contactId, String body, String? token) async {
    return await AddressServices().createAddress(contactId, body, token);
  }

  Future<dynamic> getAddressByZipCode(String zipCode) async {
    return await ApiCorreiosServices().getAddressByZipCode(zipCode);
  }
}
