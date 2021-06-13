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
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(iconOne, color: Colors.white, size: 13.0),
                Text(" $textOne",
                    style: TextStyle(color: Colors.white, fontSize: 13.0)),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 8.0)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(iconTwo, color: Colors.white, size: 13.0),
                Text(" $textTwo",
                    style: TextStyle(color: Colors.white, fontSize: 13.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
