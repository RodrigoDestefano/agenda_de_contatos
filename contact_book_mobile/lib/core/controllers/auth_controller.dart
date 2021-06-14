import 'package:flutter/cupertino.dart';

// Simple controller used to hold the token, works as an inherited widget extends provider
class AuthController extends ChangeNotifier {
  // Instance to access their parameters and methods
  static AuthController instance = AuthController();

  // Token to be held
  String token = '';

  // Replaces the token with a new value
  void addToken(String content) {
    token = content;
    // Notify all listeners about the new value of the parameter
    notifyListeners();
  }
}
