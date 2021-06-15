import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/people_api_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/helpers/google_login.dart';
import 'package:contact_book_mobile/core/models/people_api.dart';
import 'package:contact_book_mobile/core/models/user.dart';
import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:contact_book_mobile/views/home_view/page/home_page.dart';
import 'package:contact_book_mobile/views/login_view/data/login_services.dart';
import 'package:contact_book_mobile/views/login_view/widgets/custom_form_field.dart';
import 'package:contact_book_mobile/views/login_view/widgets/sign_in_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

// This file contains the entire page and call your widgets
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // It's necessary enable People Api to login:
  // https://console.cloud.google.com/apis/library/people.googleapis.com
  GoogleSignIn? _googleSignIn;
  GoogleSignInAccount? _currentUser;
  GoogleContacts? contacts;

  @override
  void initState() {
    super.initState();

    // GoogleSigIn object to access contacts
    // See all possible scopes by the link
    // https://developers.google.com/identity/protocols/oauth2/scopes#people
    // /auth/contacts.readonly: "See and download your contacts"
    // /auth/contacts: "See, edit, download, and permanently delete your contacts"
    _googleSignIn = GoogleSignIn(scopes: [
      "https://www.googleapis.com/auth/contacts",
    ]);

    // Get the users to Sign In
    _googleSignIn!.onCurrentUserChanged.listen((user) async {
      setState(() {
        _currentUser = user!;
      });

      // With a user you can now login with your Google account
      if (user != null) {
        contacts = await LoginServices().getGoogleContacts(_currentUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Your Contact's Book",
                style: GoogleFonts.pacifico(color: darkBlue, fontSize: 30.0),
              ),
              SvgPicture.asset(
                'assets/images/login_img.svg',
                height: 150.0,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 50.0),
                child: CustomFormField(
                    controller: emailController, isPassword: false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomFormField(
                    controller: passwordController, isPassword: true),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 11.0),
                child: IconButton(
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: darkBlue,
                    size: 40.0,
                  ),
                  onPressed: () => onLoginSubmit(
                      emailController.text, passwordController.text),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          Container(
            height: 40.0,
            width: 180.0,
            child: ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => SignInWidget(),
              ),
              style: ElevatedButton.styleFrom(primary: darkBlue),
              child: DefaultText(
                "Sign in",
                fontSize: 15.0,
                fontColor: defaultWhite,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          Container(
            height: 40.0,
            width: 180.0,
            child: ElevatedButton.icon(
              icon: SvgPicture.asset(
                'assets/images/google_icon.svg',
                height: 30.0,
              ),
              onPressed: () async {
                await onLoginWithGoogle();
                try {
                  // If click out the alert will be throw an Exception
                  // Then it's be necessary choose an account or create one
                  // Issue on cancel login https://github.com/flutter/flutter/issues/44431
                  await _googleSignIn!.signIn();
                } on Exception catch (error) {
                  print(error);
                }
              },
              style: ElevatedButton.styleFrom(primary: defaultWhite),
              label: DefaultText(
                "Google Sign In",
                fontSize: 15.0,
                fontColor: darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // On comunm login
  Future<void> onLoginSubmit(String email, String password) async {
    try {
      // Login service is called
      var resp = await LoginServices().login(email, password);

      if (resp['status']) {
        User user = User.fromJson(resp['user']);
        // The token is added to the AuthController
        AuthController.instance.addToken(resp['token']);
        // The user is added to the UserController
        UserController.instance.addUser(user);
        // Go to home page as comun login
        GoogleLogin args = GoogleLogin(isGoogleLogin: false);

        Navigator.of(context).pushNamed(Home.routeName, arguments: args);
      } else {
        Fluttertoast.showToast(
            msg: resp['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> onLoginWithGoogle() async {
    // Without authentication and permission will get an error to login
    // https: //console.firebase.google.com/.../authentication/providers

    if (contacts != null) {
      PeopleApiController.instance.addCurrentSignIn(_googleSignIn!);
      PeopleApiController.instance.addCurrentUser(_currentUser!);
      PeopleApiController.instance.addContacts(contacts!);

      GoogleLogin args = GoogleLogin(isGoogleLogin: true);

      Navigator.of(context).pushNamed(Home.routeName, arguments: args);

      Fluttertoast.showToast(
          msg: 'Your Google account has been successfully linked',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }
}
