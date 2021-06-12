import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/user.dart';
import 'package:contact_book_mobile/views/login_view/data/login_services.dart';
import 'package:contact_book_mobile/views/login_view/widgets/custom_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// This file contains the entire page and call your widgets
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height / 3.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red, Colors.red]),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(170))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlutterLogo(size: 150),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomFormField(
                        controller: emailController, isPassword: false)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomFormField(
                      controller: passwordController, isPassword: true),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250.0,
                    child: ElevatedButton.icon(
                      onPressed: () => onLoginSubmit(
                          emailController.text, passwordController.text),
                      icon: Icon(Icons.access_alarm_sharp),
                      label: Text("Sign in"),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    icon: Icon(Icons.access_alarm_sharp),
                    label: Text("Sign in using Google"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // On login submit button
  Future<void> onLoginSubmit(String email, String password) async {
    try {
      // Login service is called
      var resp = await LoginScreenServices().login(email, password);

      if (resp['status']) {
        User user = User.fromJson(resp['user']);
        // The token is added to the AuthController
        AuthController.instance.addToken(resp['token']);
        // The user is added to the UserController
        UserController.instance.addUser(user);
        // Go to home page
        Navigator.pushNamed(context, '/second');
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
}
