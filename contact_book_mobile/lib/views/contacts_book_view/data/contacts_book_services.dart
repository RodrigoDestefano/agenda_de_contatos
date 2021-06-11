import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/services/contact_services.dart';

// This file contains just the services call used in ContactsBook viewer
class ContactsBookServices {
  Future<List<Contact>> getContactsByUserId(int userId, String token) async {
    return await ContactServices().getContactsByUserId(userId, token);
  }
}
