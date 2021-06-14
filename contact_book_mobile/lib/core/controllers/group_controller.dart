import 'package:contact_book_mobile/core/models/group.dart';
import 'package:flutter/cupertino.dart';

// Simple controller used to hold a whole group object, works as an inherited widget extends provider
class GroupController extends ChangeNotifier {
  // Instance to access their parameters and methods
  static GroupController instance = GroupController();

  // Selected group
  Group group = Group();

  // Replaces the group with a new value
  void addGroup(Group content) {
    group = content;
    // Notify all listeners about the new value of the parameter
    notifyListeners();
  }
}
