import 'package:contact_book_mobile/core/controllers/contact_controller.dart';
import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/models/helpers/screen_arguments.dart';
import 'package:contact_book_mobile/views/add_object_view/page/add_object.dart';
import 'package:flutter/material.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  Contact contact = ContactController.instance.contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff313131),
        title: Text("Contact profile"),
      ),
      body: Container(
        color: Color(0xff181818),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.20,
              color: Color(0xff181818),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: // Catch image from https://picsum.photos/
                          ClipOval(
                        child: Image.network(
                          'https://picsum.photos/id/${contact.id}/200',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 90.0,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${contact.name}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Phone: ${contact.phone}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Email: ${contact.email}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xff313131),
              thickness: 1.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
              color: Color(0xff181818),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    IconButton(
                      onPressed: () {
                        ScreenArguments args = ScreenArguments(
                            contactId: contact.id, isAddingContact: false);

                        Navigator.of(context).pushNamed(AddObjectView.routeName,
                            arguments: args);
                      },
                      padding: EdgeInsets.only(bottom: 15.0),
                      icon: Icon(
                        Icons.add_road,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Color(0xff313131),
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
