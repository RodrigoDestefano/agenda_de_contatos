import 'package:contact_book_mobile/core/models/group.dart';
import 'package:flutter/cupertino.dart';

// Controller that contains Group
class GroupController extends ChangeNotifier {
  static GroupController instance = GroupController();

  Group group = Group();

  void addGroup(Group content) {
    group = content;
    notifyListeners();
  }
}
