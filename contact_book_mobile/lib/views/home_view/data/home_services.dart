import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/models/group.dart';
import 'package:contact_book_mobile/core/services/contact_services.dart';
import 'package:contact_book_mobile/core/services/group_services.dart';

// This file contains just the services call used in HomePage viewer
class HomePageServices {
  Future<List<Contact>> getContactsByUserId(int? userId, String? token) async {
    return await ContactServices().getContactsByUserId(userId, token);
  }

  Future<dynamic> createGroup(int userId, String token, String body) async {
    return await GroupServices().createGroup(userId, token, body);
  }

  Future<List<Contact>> getGroup(int? groupId, String? token) async {
    return await GroupServices().getGroup(groupId, token);
  }

  Future<List<Group>> getGroupsByUserId(int? userId, String? token) async {
    return await GroupServices().getGroupsByUserId(userId, token);
  }

  Future<List<Contact>> getMembersOutGroup(
      int? userId, int? groupId, String? token) async {
    return await GroupServices().getMembersOutGroup(userId, groupId, token);
  }

  Future<dynamic> addContactToGroup(
      int? contactId, String? name, String? token) async {
    return await GroupServices().addContactToGroup(contactId, name, token);
  }

  Future<dynamic> deleteContactFromGroup(
      int? contactId, String? name, String? token) async {
    return await GroupServices().deleteContactFromGroup(contactId, name, token);
  }

  Future<dynamic> deleteGroup(int? groupId, String? token) async {
    return await GroupServices().deleteGroup(groupId, token);
  }
}
