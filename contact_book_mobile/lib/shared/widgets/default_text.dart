import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Simple Text widget with Google style font
class DefaultText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final TextAlign textAlign;

  DefaultText(this.text,
      {this.fontColor = darkBlue,
      this.fontSize = 16.0,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.lato(
          color: fontColor, fontSize: fontSize, fontWeight: FontWeight.w600),
    );
  }
}
