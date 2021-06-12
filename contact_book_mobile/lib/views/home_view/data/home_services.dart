import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/services/contact_services.dart';
import 'package:contact_book_mobile/core/services/group_services.dart';

// This file contains just the services call used in HomePage viewer
class HomePageServices {
  Future<List<Contact>> getContactsByUserId(int userId, String token) async {
    return await ContactServices().getContactsByUserId(userId, token);
  }

  Future<dynamic> createGroup(int userId, String token, String body) async {
    return await GroupServices().createGroup(userId, token, body);
  }
}
