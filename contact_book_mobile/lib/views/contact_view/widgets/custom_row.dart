import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomRow extends StatelessWidget {
  String? textOne, textTwo;
  IconData iconOne, iconTwo;

  CustomRow(
      {Key? key,
      required this.textOne,
      required this.textTwo,
      required this.iconOne,
      required this.iconTwo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(iconOne, color: darkBlue, size: 15.0),
                DefaultText(" $textOne", fontSize: 15.0),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 8.0)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(iconTwo, color: darkBlue, size: 15.0),
                DefaultText(" $textTwo", fontSize: 15.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
