import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 45.0,
        minHeight: 30.0,
        maxWidth: 300.0,
        minWidth: 200.0,
      ),
      child: Container(
        child: TextFormField(
          controller: widget.controller,
          style: GoogleFonts.lato(
            color: darkBlue,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: widget.isPassword ? "Password" : "Email",
            labelText: widget.isPassword ? "Password" : "Email",
            filled: true,
            prefixIcon: widget.isPassword
                ? Icon(
                    Icons.lock,
                    size: 16.0,
                    color: darkBlue,
                  )
                : Icon(
                    Icons.verified_user_rounded,
                    size: 16.0,
                    color: darkBlue,
                  ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    iconSize: 16.0,
                    color: darkBlue,
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  )
                : null,
            fillColor: defaultWhite,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: darkBlue),
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: defaultBlue),
              borderRadius: BorderRadius.circular(50.0),
            ),
            contentPadding: EdgeInsets.only(top: 5.0, left: 15.0),
          ),
          obscureText: widget.isPassword ? !showPassword : false,
          obscuringCharacter: "*",
        ),
      ),
    );
  }
}
