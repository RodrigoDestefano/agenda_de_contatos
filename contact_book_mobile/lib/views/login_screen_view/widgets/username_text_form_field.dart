import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsernameTextFormField extends StatefulWidget {
  const UsernameTextFormField();

  @override
  UsernameTextFormFieldState createState() {
    return UsernameTextFormFieldState();
  }
}

class UsernameTextFormFieldState extends State<UsernameTextFormField> {
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
              Icons.person,
              size: 20.0,
              color: Colors.black45,
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
            hintText: "Username",
          )),
    );
  }
}
