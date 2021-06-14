import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:flutter/cupertino.dart';

// Simple controller used to hold a whole contact object, works as an inherited widget extends provider
class ContactController extends ChangeNotifier {
  // Instance to access their parameters and methods
  static ContactController instance = ContactController();

  // Selected contact
  Contact contact = Contact();

  // Replaces the contact with a new value
  void addContact(Contact content) {
    contact = content;
    // Notify all listeners about the new value of the parameter
    notifyListeners();
  }
}
