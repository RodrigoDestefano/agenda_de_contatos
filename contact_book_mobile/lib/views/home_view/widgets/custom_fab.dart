import 'dart:math';

import 'package:contact_book_mobile/core/models/helpers/screen_arguments.dart';
import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/views/add_object_view/page/add_object.dart';
import 'package:contact_book_mobile/views/home_view/widgets/add_group_widget.dart';
import 'package:flutter/material.dart';

class CustomFab extends StatefulWidget {
  const CustomFab({Key? key}) : super(key: key);

  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  static bool toggle = true;
  late AnimationController controller;
  late Animation<double> animation;
  Alignment addPersonAlignment = Alignment(0.0, 0.0);
  Alignment addGroupAlignment = Alignment(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 250),
        reverseDuration: Duration(milliseconds: 175));

    animation = CurvedAnimation(
        parent: controller, curve: Curves.easeOut, reverseCurve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomRight,
      child: Container(
        height: 250.0,
        width: 70.0,
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: addPersonAlignment + Alignment.bottomCenter,
              curve: toggle ? Curves.easeIn : Curves.elasticOut,
              duration: toggle
                  ? Duration(milliseconds: 175)
                  : Duration(milliseconds: 775),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 375),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1.0,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 0.0), // changes position of shadow
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(40.0),
                  child: IconButton(
                    splashColor: Colors.black54,
                    splashRadius: 31.0,
                    tooltip: "Add a new contact",
                    icon: Icon(
                      Icons.person_add_alt_1,
                      color: defaultWhite,
                      size: 21.0,
                    ),
                    onPressed: () {
                      ScreenArguments args =
                          ScreenArguments(contactId: 0, isAddingContact: true);

                      Navigator.of(context)
                          .pushNamed(AddObjectView.routeName, arguments: args);
                    },
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              alignment: addGroupAlignment + Alignment.bottomCenter,
              curve: toggle ? Curves.easeIn : Curves.elasticOut,
              duration: toggle
                  ? Duration(milliseconds: 175)
                  : Duration(milliseconds: 775),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1.0,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 0.0), // changes position of shadow
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(40.0),
                  child: IconButton(
                    splashColor: Colors.black54,
                    splashRadius: 31.0,
                    tooltip: "Add a new group",
                    icon: Icon(
                      Icons.group_add,
                      color: defaultWhite,
                      size: 21.0,
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AddGroupWidget();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: animation.value * pi * (3 / 4),
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 275),
                    curve: Curves.easeOut,
                    height: 65.0,
                    width: 65.0,
                    decoration: BoxDecoration(
                      color: darkBlue,
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2.0,
                          blurRadius: 4.0,
                          offset:
                              Offset(0.0, 0.0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                          splashColor: Colors.black54,
                          splashRadius: 31.0,
                          onPressed: () {
                            if (!toggle) {
                              toggle = !toggle;
                              controller.forward();
                              Future.delayed(Duration(milliseconds: 50), () {
                                addGroupAlignment = Alignment(0.0, -0.75);
                              });
                              Future.delayed(Duration(milliseconds: 100), () {
                                addPersonAlignment = Alignment(0.0, -1.3);
                              });
                            } else {
                              toggle = !toggle;
                              controller.reverse();
                              addPersonAlignment = Alignment(0.0, 0.0);
                              addGroupAlignment = Alignment(0.0, 0.0);
                            }
                          },
                          icon: Icon(
                            Icons.add,
                            color: defaultWhite,
                            size: 27.0,
                          )),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
