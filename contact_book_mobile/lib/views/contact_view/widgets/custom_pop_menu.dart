import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
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
      color: Color(0xff313131),
      icon: Icon(Icons.more_vert, color: Colors.white),
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
              color: Colors.white,
              size: 20.0,
            ),
            title: Text(
              'Edit',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
        ),
        PopupMenuItem<Father>(
          value: Father.delete,
          child: ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.white,
              size: 20.0,
            ),
            title: Text(
              'Delete',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
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
          title: new Text("Alert"),
          content: new Text("Do you really want to delete this contact?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => deleteObject(objectId),
              child: const Text('Yes'),
            ),
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
          textColor: Colors.white,
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
