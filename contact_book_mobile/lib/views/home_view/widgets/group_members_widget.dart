import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/group_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/models/group.dart';
import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:contact_book_mobile/views/home_view/data/home_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class GroupMembersWidget extends StatefulWidget {
  bool isAdding = false;
  GroupMembersWidget({Key? key, required this.isAdding}) : super(key: key);

  @override
  _GroupMembersWidgetState createState() => _GroupMembersWidgetState();
}

class _GroupMembersWidgetState extends State<GroupMembersWidget> {
  Group group = GroupController.instance.group;

  int? userId = UserController.instance.user.id;
  String? token = AuthController.instance.token;

  late Future<List<Contact>> contactsGroup;
  late Future<List<Contact>> membersOutGroup;

  @override
  Widget build(BuildContext context) {
    membersOutGroup =
        HomePageServices().getMembersOutGroup(userId, group.id, token);
    contactsGroup = HomePageServices().getGroup(group.id, token);

    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
      body: SimpleDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: darkBlue),
            borderRadius: new BorderRadius.circular(10.0)),
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(0),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0)),
              color: darkBlue,
            ),
            child: Center(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: defaultWhite,
                        size: 20.0,
                      )),
                  DefaultText(
                    widget.isAdding
                        ? 'Add contact to ${group.name}'
                        : "${group.name} members",
                    fontColor: defaultWhite,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 260.0,
            child: SingleChildScrollView(
              child: Container(
                width: 100.0,
                height: 250.0,
                child: FutureBuilder(
                  future: widget.isAdding ? membersOutGroup : contactsGroup,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.length == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/any_contact_in_group_img.svg',
                                  height: 100.0,
                                ),
                                Padding(padding: EdgeInsets.all(8.0)),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: 200.0,
                                    minHeight: 100.0,
                                    maxWidth: 200.0,
                                    minWidth: 150.0,
                                  ),
                                  child: DefaultText(
                                    widget.isAdding
                                        ? "No contacts available to add, create more and add then!"
                                        : "This group has no contacts yet, add someone!",
                                    fontSize: 20.0,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    // Catch image from https://picsum.photos/
                                    child: ClipOval(
                                      child: Image.network(
                                          'https://picsum.photos/id/${snapshot.data[index].id}/200'),
                                    ),
                                  ),
                                  title: Text("${snapshot.data[index].name}"),
                                  subtitle:
                                      Text("${snapshot.data[index].phone}"),
                                  trailing: IconButton(
                                    icon: Icon(
                                      widget.isAdding
                                          ? Icons.add
                                          : Icons.remove,
                                      color: darkBlue,
                                    ),
                                    onPressed: () {
                                      addOrDeleteToGroup(
                                          snapshot.data[index].id, group.name);
                                    },
                                  ),
                                );
                              },
                            );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addOrDeleteToGroup(int? contactId, String? name) async {
    try {
      var resp;

      if (widget.isAdding) {
        resp =
            await HomePageServices().addContactToGroup(contactId, name, token);
      } else {
        resp = await HomePageServices()
            .deleteContactFromGroup(contactId, name, token);
      }

      Fluttertoast.showToast(
          msg: resp['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: resp['status'] ? Colors.green : Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);

      if (resp['status']) setState(() {});
    } catch (error) {
      print(error);
    }
  }
}
