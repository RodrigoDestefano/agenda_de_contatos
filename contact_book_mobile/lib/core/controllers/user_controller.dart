import 'package:contact_book_mobile/core/models/user.dart';
import 'package:flutter/cupertino.dart';

// Simple controller used to hold the current logged user, works as an inherited widget extends provider
class UserController extends ChangeNotifier {
  // Instance to access their parameters and methods
  static UserController instance = UserController();

  // Current user
  User user = User();

  // Replaces the user with the logged in
  void addUser(User content) {
    user = content;
    // Notify all listeners about the new value of the parameter
    notifyListeners();
  }
}
