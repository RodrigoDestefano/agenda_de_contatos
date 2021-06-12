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
      color: Colors.redAccent,
    );
    // return Container(
    //   color: Color(0xff181818),
    //   child: FutureBuilder(
    //     future: GroupServices().getGroupsByUserId(
    //         UserController.instance.user.id, AuthController.instance.token),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasData) {
    //         return RefreshIndicator(
    //           onRefresh: () async {
    //             setState(() {});
    //           },
    //           child: ListView.builder(
    //             itemCount: snapshot.data.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               return ListTile(
    //                 leading: Container(
    //                   width: 40.0,
    //                   height: 40.0,
    //                   // Catch image from https://picsum.photos/
    //                   child: ClipOval(
    //                     child: Image.network(
    //                         'https://picsum.photos/id/${snapshot.data[index].id + 20}/200'),
    //                   ),
    //                 ),
    //                 title: Text("${snapshot.data[index].name}",
    //                     style: TextStyle(color: Colors.white)),
    //                 subtitle: Text("${snapshot.data[index].phone}",
    //                     style: TextStyle(color: Colors.white)),
    //                 onTap: () => {},
    //               );
    //             },
    //           ),
    //         );
    //       } else {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //     },
    //   ),
    // );
  }
}
