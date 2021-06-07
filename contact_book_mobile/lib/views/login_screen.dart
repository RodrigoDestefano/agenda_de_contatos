import 'package:contact_book_mobile/widgets/username_text_form_field.dart';
import 'package:contact_book_mobile/widgets/password_text_form_fiel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xff3fa1ff),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlutterLogo(size: 200),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UsernameTextFormField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordTextFormField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 250.0,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.access_alarm_sharp),
                  label: Text("Sign in with Google"),
                ),
              ),
            ),
            Container(
              width: 250.0,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.red),
                icon: Icon(Icons.access_alarm_sharp),
                label: Text("Sign in with Google"),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
