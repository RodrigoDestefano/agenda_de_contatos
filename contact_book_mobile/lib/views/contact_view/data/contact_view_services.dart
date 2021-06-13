import 'package:contact_book_mobile/core/services/address_services.dart';
import 'package:contact_book_mobile/core/services/contact_services.dart';

class ContactViewServices {
  Future<dynamic> getAllAddressByContactId(
      int? contactId, String? token) async {
    return await AddressServices().getAllAddressByContactId(contactId, token);
  }

  Future<dynamic> deleteContact(int? contactId, String? token) async {
    return await ContactServices().deleteContact(contactId, token);
  }

  Future<dynamic> deleteAddress(int? addressId, String? token) async {
    return await AddressServices().deleteAddress(addressId, token);
  }
}
