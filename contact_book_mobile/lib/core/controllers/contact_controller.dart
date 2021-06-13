import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:flutter/cupertino.dart';

// Controller that will contain the chosen contact to view the profile
class ContactController extends ChangeNotifier {
  static ContactController instance = ContactController();

  Contact contact = Contact();

  void addContact(Contact content) {
    contact = content;
    notifyListeners();
  }
}
