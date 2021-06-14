import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/contact_controller.dart';
import 'package:contact_book_mobile/core/controllers/people_api_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/core/models/people_api.dart';
import 'package:contact_book_mobile/views/home_view/data/home_services.dart';
import 'package:contact_book_mobile/views/home_view/widgets/people_api_widget.dart';
import 'package:flutter/material.dart';

// This file is a specific widget from HomePage
// ignore: must_be_immutable
class ContactsTab extends StatefulWidget {
  bool isGoogleLogin = false;
  ContactsTab({Key? key, required this.isGoogleLogin}) : super(key: key);

  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  TextEditingController searchInputController = TextEditingController();

  late List<Contact> contacts = [];
  late List<Contact> foudContacts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3fa1ff),
        automaticallyImplyLeading: false,
        title: Container(
          height: 33.0,
          child: TextField(
              controller: searchInputController,
              onChanged: onSearchTextChanged,
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xffbdc6cf),
              ),
              decoration: InputDecoration(
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      if (!isControllerEmpty()) {
                        searchInputController.clear();
                        foudContacts = contacts;
                      }
                    });
                  },
                  icon: isControllerEmpty()
                      ? Icon(Icons.search)
                      : Icon(Icons.search_off),
                  iconSize: 20.0,
                  padding: EdgeInsets.only(bottom: 2.0),
                  color: Colors.black45,
                ),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                contentPadding: EdgeInsets.only(top: 5.0, left: 15.0),
                hintText: "Search for a contact",
              )),
        ),
      ),
      body: Container(
        child: widget.isGoogleLogin
            ? PeopleApiWidget()
            : FutureBuilder(
                future: HomePageServices().getContactsByUserId(
                    UserController.instance.user.id,
                    AuthController.instance.token),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    contacts = snapshot.data;

                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: contacts.length == 0
                          ? Center(
                              child: Text(
                                "You don't have any contacts yet",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                              ),
                            )
                          : ListView.separated(
                              itemCount: isControllerEmpty()
                                  ? contacts.length
                                  : foudContacts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    // Catch image from https://picsum.photos/
                                    child: ClipOval(
                                      child: Image.network(
                                          'https://picsum.photos/id/${contacts[index].id}/200'),
                                    ),
                                  ),
                                  title: Text(
                                      isControllerEmpty()
                                          ? "${contacts[index].name}"
                                          : "${foudContacts[index].name}",
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: Text(
                                      isControllerEmpty()
                                          ? "${contacts[index].phone}"
                                          : "${foudContacts[index].phone}",
                                      style: TextStyle(color: Colors.white)),
                                  onTap: () => {
                                    ContactController.instance.addContact(
                                        isControllerEmpty()
                                            ? contacts[index]
                                            : foudContacts[index]),
                                    Navigator.pushNamed(context, '/fourth')
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(),
                            ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
      ),
    );
  }

  void onSearchTextChanged(String text) async {
    setState(() {
      var iterable = contacts.where((element) =>
          (element.name.toLowerCase().contains(searchInputController.text)));

      foudContacts = iterable.toList();
    });
  }

  bool isControllerEmpty() {
    return searchInputController.text == "" ? true : false;
  }
}
