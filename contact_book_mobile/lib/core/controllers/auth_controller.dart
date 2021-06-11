import 'package:flutter/cupertino.dart';

// Simple controller used to hold the token, works as an inherited widget
class AuthController extends ChangeNotifier {
  String token = '';

  void addToken(String content) {
    token = content;
    notifyListeners();
  }
}
