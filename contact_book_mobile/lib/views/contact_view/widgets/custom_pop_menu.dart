import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:contact_book_mobile/views/contact_view/data/contact_view_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class CustomPopMenu extends StatefulWidget {
  int? objectId;
  bool isContact = true;
  CustomPopMenu({Key? key, required this.objectId, required this.isContact})
      : super(key: key);

  @override
  _CustomPopMenuState createState() => _CustomPopMenuState();
}

enum Father { edit, delete }

class _CustomPopMenuState extends State<CustomPopMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Father>(
      color: widget.isContact ? defaultWhite : darkBlue,
      icon: Icon(Icons.more_vert,
          color: widget.isContact ? defaultWhite : darkBlue),
      onSelected: (Father result) {
        if (result.index == 1) {
          widget.isContact
              ? _showDialog(context, widget.objectId)
              : deleteObject(widget.objectId);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Father>>[
        PopupMenuItem<Father>(
          value: Father.edit,
          child: ListTile(
            leading: Icon(
              Icons.edit,
              color: widget.isContact ? darkBlue : defaultWhite,
              size: 20.0,
            ),
            title: DefaultText('Edit',
                fontColor: widget.isContact ? darkBlue : defaultWhite,
                fontSize: 15.0),
          ),
        ),
        PopupMenuItem<Father>(
          value: Father.delete,
          child: ListTile(
            leading: Icon(
              Icons.delete,
              color: widget.isContact ? darkBlue : defaultWhite,
              size: 20.0,
            ),
            title: DefaultText(
              'Delete',
              fontColor: widget.isContact ? darkBlue : defaultWhite,
              fontSize: 15.0,
            ),
          ),
        )
      ],
    );
  }

  void _showDialog(BuildContext context, int? objectId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: DefaultText(
            "Alert!",
            fontSize: 25.0,
          ),
          content: DefaultText("Do you really want to delete this contact?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: DefaultText(
                  'No',
                  fontSize: 20,
                )),
            TextButton(
                onPressed: () => deleteObject(objectId),
                child: DefaultText(
                  'Yes',
                  fontSize: 20,
                )),
          ],
        );
      },
    );
  }

  Future<void> deleteObject(int? objectId) async {
    try {
      var resp;

      if (widget.isContact) {
        resp = await ContactViewServices()
            .deleteContact(objectId, AuthController.instance.token);
      } else {
        resp = await ContactViewServices()
            .deleteAddress(objectId, AuthController.instance.token);
      }

      Fluttertoast.showToast(
          msg: resp['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: resp['status'] ? Colors.green : Colors.red,
          textColor: defaultWhite,
          fontSize: 10.0);

      if (resp['status']) {
        if (widget.isContact) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      }
    } catch (error) {
      print(error);
    }
  }
}
