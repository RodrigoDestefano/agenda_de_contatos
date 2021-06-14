import 'package:contact_book_mobile/core/models/people_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

// For the code to login with a Google account and use the People API, only 3 objects were used:
// The Sign In: It's necessary a register to access the platform and their functions
// The own Account: A Google account that has data access permissions
// And the contacts: The contacts objects that will be request
class PeopleApiController extends ChangeNotifier {
  // Instance to access their parameters and methods
  static PeopleApiController instance = PeopleApiController();

  // The Sign In object
  GoogleSignIn? googleSignIn;
  // The Google account object
  GoogleSignInAccount? currentUser;
  // The whole contacts object
  GoogleContacts? contacts;

  // Replaces the Sign In with a new value
  void addCurrentSignIn(GoogleSignIn? content) {
    googleSignIn = content;
    // Notify all listeners about the new value of the parameter
    notifyListeners();
  }

  // Replaces the Google account with a new value
  void addCurrentUser(GoogleSignInAccount? content) {
    currentUser = content;
    // Notify all listeners about the new value of the parameter
    notifyListeners();
  }

  // Replaces the contacts with a new value
  void addContacts(GoogleContacts? content) {
    contacts = content;
    // Notify all listeners about the new value of the parameter
    notifyListeners();
  }
}
