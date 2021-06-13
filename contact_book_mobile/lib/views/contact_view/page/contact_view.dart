import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/contact_controller.dart';
import 'package:contact_book_mobile/core/models/address.dart';
import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/models/helpers/screen_arguments.dart';
import 'package:contact_book_mobile/views/add_object_view/page/add_object.dart';
import 'package:contact_book_mobile/views/contact_view/data/contact_view_services.dart';
import 'package:contact_book_mobile/views/contact_view/widgets/custom_pop_menu.dart';
import 'package:contact_book_mobile/views/contact_view/widgets/custom_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  Contact contact = ContactController.instance.contact;

  List<Address> address = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff313131),
        title: Text("Contact profile"),
        actions: [
          CustomPopMenu(objectId: contact.id, isContact: true),
        ],
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
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              Text(
                                '  ${contact.name}',
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
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              Text(
                                '  ${contact.phone}',
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
                              Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              Text(
                                '  ${contact.email}',
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
                        Icons.add,
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
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              color: Color(0xff181818),
              child: FutureBuilder(
                future: ContactViewServices().getAllAddressByContactId(
                    ContactController.instance.contact.id,
                    AuthController.instance.token),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    address = snapshot.data;

                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: ListView.builder(
                        itemCount: address.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5.0,
                            color: Color(0xff313131),
                            child: ListTile(
                                title: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                          Text(
                                            " ${address[index].phone}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                          Text(
                                            " ${address[index].email}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Container(
                                  child: Column(
                                    children: [
                                      Divider(
                                        color: Color(0xff181818),
                                        thickness: 1.0,
                                      ),
                                      CustomRow(
                                          iconOne: Icons.post_add,
                                          iconTwo: Icons.account_balance,
                                          textOne: address[index].zipCode,
                                          textTwo: address[index].uf),
                                      CustomRow(
                                          iconOne: Icons.location_city,
                                          iconTwo: Icons.home_filled,
                                          textOne: address[index].city,
                                          textTwo: address[index].district),
                                      CustomRow(
                                          iconOne: Icons.add_road_sharp,
                                          iconTwo: Icons.confirmation_number,
                                          textOne: address[index].street,
                                          textTwo: address[index].number),
                                    ],
                                  ),
                                ),
                                trailing: CustomPopMenu(
                                    objectId: address[index].id,
                                    isContact: false)),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
