import 'package:http/http.dart' as http;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:contact_book_mobile/core/models/people_api.dart';

// To do a request in https://people.googleapis.com you need to create a project in
// https://console.firebase.google.com and link the project with the flutter app
//
// **** The SHA1 key asked (as optional) to link the project with firebase is necessary for People API ****
// To catch this SHA1 key you can follow the steps in: https://bit.ly/3iDnb31
//
// After this you need to enable Google in the Authentications
// by https://console.firebase.google.com/.../authentication/providers
// Then you can access and enable enable Google People API at
// https://console.cloud.google.com/marketplace/product/google/people.googleapis.com
//
// The request used in this project can be found in:
// https://developers.google.com/people/v1/contacts

class PeopleApiServices {
  //################################ GET ################################

  Future<GoogleContacts?> getGoogleContacts(
      GoogleSignInAccount? currentUser) async {
    GoogleContacts? contacts;

    final host = "https://people.googleapis.com";
    final path = "/v1/people/me/connections?personFields=names,phoneNumbers";
    final header = await currentUser!.authHeaders;

    var url = Uri.parse(('$host$path'));

    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      contacts = googleContactsFromJson(response.body);
      return contacts;
    } else {
      print('Error ${response.statusCode}: ${response.body}');
    }

    return contacts;
  }
}
