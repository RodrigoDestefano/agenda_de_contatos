import 'package:contact_book_mobile/core/models/user.dart';
import 'package:flutter/cupertino.dart';

// Controller that contains the logged user
class UserController extends ChangeNotifier {
  User user = User();

  void addUser(User content) {
    user = content;
    notifyListeners();
  }
}