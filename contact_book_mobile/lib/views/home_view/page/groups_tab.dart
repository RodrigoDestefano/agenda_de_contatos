import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/group_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/services/group_services.dart';
import 'package:contact_book_mobile/views/home_view/widgets/group_members_widget.dart';
import 'package:flutter/material.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({Key? key}) : super(key: key);

  @override
  _GroupsTabState createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff181818),
      child: FutureBuilder(
        future: GroupServices().getGroupsByUserId(
            UserController.instance.user.id, AuthController.instance.token),
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
                                builder: (context) => GroupMembersWidget());
                          },
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
}
