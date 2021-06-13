import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/group_controller.dart';
import 'package:contact_book_mobile/core/models/group.dart';
import 'package:contact_book_mobile/core/services/group_services.dart';
import 'package:flutter/material.dart';

class GroupMembersWidget extends StatefulWidget {
  const GroupMembersWidget({Key? key}) : super(key: key);

  @override
  _GroupMembersWidgetState createState() => _GroupMembersWidgetState();
}

class _GroupMembersWidgetState extends State<GroupMembersWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
      body: SimpleDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: Colors.black54),
            borderRadius: new BorderRadius.circular(10.0)),
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(0),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0)),
              color: Color(0xff3fa1ff),
            ),
            child: Center(
                child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20.0,
                    )),
                Text(
                  "${GroupController.instance.group.name} members",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
          ),
          SingleChildScrollView(
            child: Container(
              width: 100.0,
              height: 200.0,
              child: FutureBuilder(
                future: GroupServices().getGroup(
                    GroupController.instance.group.id,
                    AuthController.instance.token),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.length == 0
                        ? Center(
                            child: Text(
                              "This group has no contacts yet",
                              style: TextStyle(fontSize: 18.0),
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
                                        'https://picsum.photos/id/${snapshot.data[index].id}/200'),
                                  ),
                                ),
                                title: Text("${snapshot.data[index].name}"),
                                subtitle: Text("${snapshot.data[index].phone}"),
                                onTap: () {},
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
        ],
      ),
    );
  }
}
