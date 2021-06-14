import 'package:contact_book_mobile/core/models/people_api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

// All models references in https://developers.google.com/people/api/rest/v1/
class PeopleApiServices {
  //################################ GET ################################
  Future<GoogleContacts?> getUserContacts(
      GoogleSignInAccount? currentUser) async {
    GoogleContacts? contacts;
    // Enable Google People API at
    // https://console.cloud.google.com/marketplace/product/google/people.googleapis.com

    // The host and GET request at https://developers.google.com/people/v1/contacts
    final host = "https://people.googleapis.com";
    final endPoint =
        "/v1/people/me/connections?personFields=names,phoneNumbers";
    final header = await currentUser!.authHeaders;

    var url = Uri.parse(('$host$endPoint'));

    // Is necessary enable the People API before the request
    // https: //console.developers.google.com/apis/api/people.googleapis.com/overview?project=160237726092
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
