import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  @override
  PasswordTextFormFieldState createState() {
    return PasswordTextFormFieldState();
  }
}

class PasswordTextFormFieldState extends State<PasswordTextFormField> {
  static bool _hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 33.0,
      child: TextField(
        style: TextStyle(
          fontSize: 13.0,
          color: Color(0xffbdc6cf),
        ),
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(
            Icons.ac_unit,
            size: 20.0,
            color: Colors.black45,
          ),
          suffixIcon: IconButton(
            iconSize: 19.0,
            color: Colors.black45,
            icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
          ),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(50.0),
          ),
          contentPadding: EdgeInsets.only(top: 5.0, left: 15.0),
          hintText: "Enter with your password",
        ),
        obscureText: !_hidePassword,
        obscuringCharacter: "*",
      ),
    );
  }
}
