import 'package:contact_book_mobile/core/services/user_services.dart';

// This file contains just the services call used in LoginScreen viewer
class LoginServices {
  Future<dynamic> login(String email, String password) async {
    return await UserServices().login(email, password);
  }

  Future<dynamic> createUser(
      String? name, String? email, String? password) async {
    return await UserServices().createUser(name, email, password);
  }
}
