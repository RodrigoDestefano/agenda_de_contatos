import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/group_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/user.dart';
import 'package:contact_book_mobile/views/home_view/data/home_services.dart';
import 'package:contact_book_mobile/views/home_view/widgets/group_members_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({Key? key}) : super(key: key);

  @override
  _GroupsTabState createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  User user = UserController.instance.user;
  String? token = AuthController.instance.token;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff181818),
      child: FutureBuilder(
        future: HomePageServices().getGroupsByUserId(user.id, token),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: snapshot.data.length == 0
                  ? Center(
                      child: Text(
                        "You don't have any groups yet",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
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
                                  'https://picsum.photos/id/${snapshot.data[index].id + 20}/200'),
                            ),
                          ),
                          title: Text("${snapshot.data[index].name}",
                              style: TextStyle(color: Colors.white)),
                          onTap: () {
                            GroupController.instance
                                .addGroup(snapshot.data[index]);
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    GroupMembersWidget(isAdding: false));
                          },
                          trailing: Container(
                            height: 50.0,
                            width: 100.0,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            GroupMembersWidget(isAdding: true));
                                  },
                                  icon: Icon(
                                    Icons.person_add_alt_1,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _showDialog(
                                      context, snapshot.data[index].id),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
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
          title: new Text("Alert"),
          content: new Text("Do you really want to delete this group?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                deleteGroup(groupId);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
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
