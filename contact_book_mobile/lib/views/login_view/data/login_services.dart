import 'package:contact_book_mobile/core/models/people_api.dart';
import 'package:contact_book_mobile/core/services/people_api_services.dart';
import 'package:contact_book_mobile/core/services/user_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

// This file contains just the services call used in LoginScreen viewer
class LoginServices {
  Future<dynamic> login(String email, String password) async {
    return await UserServices().login(email, password);
  }

  Future<dynamic> createUser(
      String? name, String? email, String? password) async {
    return await UserServices().createUser(name, email, password);
  }

  Future<GoogleContacts?> getGoogleContacts(
      GoogleSignInAccount? currentUser) async {
    return await PeopleApiServices().getGoogleContacts(currentUser!);
  }
}
