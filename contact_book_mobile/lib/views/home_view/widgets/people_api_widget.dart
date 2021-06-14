import 'package:contact_book_mobile/core/controllers/people_api_controller.dart';
import 'package:contact_book_mobile/core/models/people_api.dart';
import 'package:flutter/material.dart';

class PeopleApiWidget extends StatefulWidget {
  const PeopleApiWidget({Key? key}) : super(key: key);

  @override
  _PeopleApiWidgetState createState() => _PeopleApiWidgetState();
}

class _PeopleApiWidgetState extends State<PeopleApiWidget> {
  @override
  Widget build(BuildContext context) {
    GoogleContacts? contacts = PeopleApiController.instance.contacts;

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        final currentContact = contacts!.connections[index];
        return ListTile(
          leading: Container(
            width: 40.0,
            height: 40.0,
            // Catch image from https://picsum.photos/
            child: ClipOval(
              child:
                  Image.network('https://picsum.photos/id/${index + 30}/200'),
            ),
          ),
          title: Text("${currentContact.names!.first.displayName}"),
          subtitle: Text("${currentContact.phoneNumbers!.first.value}"),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: contacts!.connections.length,
    );
  }
}
