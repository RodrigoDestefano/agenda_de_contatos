import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/group_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/group.dart';
import 'package:contact_book_mobile/core/models/user.dart';
import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:contact_book_mobile/views/home_view/data/home_services.dart';
import 'package:contact_book_mobile/views/home_view/widgets/group_members_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({Key? key}) : super(key: key);

  @override
  _GroupsTabState createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  User user = UserController.instance.user;
  String? token = AuthController.instance.token;

  late List<Group> groups = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: defaultWhite,
      child: FutureBuilder(
        future: HomePageServices().getAllGroupsByUserId(user.id, token),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              backgroundColor: darkBlue,
              color: defaultWhite,
              strokeWidth: 2.0,
              onRefresh: () async {
                setState(() {});
              },
              child: snapshot.data.length == 0
                  ? Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 300.0,
                          minHeight: 200.0,
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                          minWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/images/any_group_img.svg',
                                height: 150.0,
                              ),
                              Padding(padding: EdgeInsets.all(8.0)),
                              DefaultText(
                                "You don't have any group yet try to create one!",
                                fontSize: 23.0,
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.refresh_outlined,
                                  color: darkBlue,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 60.0,
                                      maxWidth: 60.0,
                                      minHeight: 40.0,
                                      minWidth: 40.0,
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                          'https://picsum.photos/id/${snapshot.data[index].id + 20}/200'),
                                    ),
                                  ),
                                  title: DefaultText(
                                    "${snapshot.data[index].name}",
                                  ),
                                  onTap: () {
                                    GroupController.instance
                                        .addGroup(snapshot.data[index]);
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            GroupMembersWidget(
                                                isAdding: false));
                                  },
                                  trailing: Container(
                                    height: 50.0,
                                    width: 100.0,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            GroupController.instance
                                                .addGroup(snapshot.data[index]);
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    GroupMembersWidget(
                                                        isAdding: true));
                                          },
                                          icon: Icon(
                                            Icons.person_add_alt_1,
                                            color: darkBlue,
                                            size: 20.0,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => _showDialog(
                                              context, snapshot.data[index].id),
                                          icon: Icon(
                                            Icons.delete,
                                            color: darkBlue,
                                            size: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Divider(
                                    color: darkBlue,
                                    thickness: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: defaultWhite,
              color: darkBlue,
              strokeWidth: 2.0,
            ));
          }
        },
      ),
    );
  }

  void _showDialog(BuildContext context, int? groupId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: darkBlue,
          title: DefaultText(
            "Alert!",
            fontColor: defaultWhite,
            fontSize: 25.0,
          ),
          content: DefaultText(
            "Do you really want to delete this group?",
            fontColor: defaultWhite,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: DefaultText(
                'No',
                fontSize: 20,
                fontColor: defaultWhite,
              ),
            ),
            TextButton(
              onPressed: () {
                deleteGroup(groupId);
                Navigator.of(context).pop();
              },
              child: DefaultText(
                'Yes',
                fontSize: 20,
                fontColor: defaultWhite,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteGroup(int? groupId) async {
    try {
      var resp = await HomePageServices().deleteGroup(groupId, token);

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
