import 'package:contact_book_mobile/views/contact_profile/widgets/add_contact_widget.dart';
import 'package:flutter/material.dart';

// This file contains the entire page and call your widgets
class ContactProfile extends StatefulWidget {
  const ContactProfile({Key? key}) : super(key: key);

  @override
  _ContactProfileState createState() => _ContactProfileState();
}

class _ContactProfileState extends State<ContactProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Name',
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Color(0xff181818),
      ),
      body: Container(
        color: Color(0xff181818),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: Center(
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  // Catch image from https://picsum.photos/
                  child: ClipOval(
                    child: Image.network('https://picsum.photos/id/${1}/200'),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                child: AddContactWidget())
          ],
        ),
      ),
    );
  }
}
