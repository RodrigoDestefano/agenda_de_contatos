import 'package:contact_book_mobile/core/models/people_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Controller that contains the logged user by google api
class PeopleApiController extends ChangeNotifier {
  static PeopleApiController instance = PeopleApiController();

  GoogleSignIn? googleSignIn;
  GoogleSignInAccount? currentUser;
  GoogleContacts? contacts;

  void addCurrentSignIn(GoogleSignIn? content) {
    googleSignIn = content;
    notifyListeners();
  }

  void addCurrentUser(GoogleSignInAccount? content) {
    currentUser = content;
    notifyListeners();
  }

  void addContacts(GoogleContacts? content) {
    contacts = content;
    notifyListeners();
  }
}
