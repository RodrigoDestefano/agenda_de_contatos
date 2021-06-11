import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This file is a specific widget from LoginScreen
// ignore: must_be_immutable
class CustomFormField extends StatefulWidget {
  bool isPassword;
  TextEditingController controller;

  CustomFormField({required this.controller, required this.isPassword});

  @override
  CustomFormFieldState createState() {
    return CustomFormFieldState();
  }
}

class CustomFormFieldState extends State<CustomFormField> {
  static bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 33.0,
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(
          fontSize: 13.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: widget.isPassword ? "Password" : "Email",
          labelText: widget.isPassword ? "Password" : "Email",
          filled: true,
          prefixIcon: widget.isPassword
              ? Icon(
                  Icons.lock,
                  size: 16.0,
                  color: Colors.black45,
                )
              : Icon(
                  Icons.verified_user_rounded,
                  size: 16.0,
                  color: Colors.black45,
                ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  iconSize: 16.0,
                  color: Colors.black45,
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : null,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff3fa1ff)),
            borderRadius: BorderRadius.circular(50.0),
          ),
          contentPadding: EdgeInsets.only(top: 5.0, left: 15.0),
        ),
        obscureText: widget.isPassword ? !showPassword : false,
        obscuringCharacter: "*",
      ),
    );
  }
}
