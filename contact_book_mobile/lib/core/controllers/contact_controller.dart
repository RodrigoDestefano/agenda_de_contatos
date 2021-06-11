import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:flutter/cupertino.dart';

// Controller that will contain the chosen contact to view the profile
class ContactController extends ChangeNotifier {
  Contact contact = Contact(createdAt: null);

  void addContact(Contact content) {
    contact = content;
    print(contact.toJson());
    notifyListeners();
  }
}
