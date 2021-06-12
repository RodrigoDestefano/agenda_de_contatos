import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/contact_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/services/contact_services.dart';
import 'package:flutter/material.dart';

// This file is a specific widget from HomePage
// ignore: must_be_immutable
class ContactsTab extends StatefulWidget {
  ContactsTab({Key? key}) : super(key: key);

  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  TextEditingController searchInputController = TextEditingController();

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
                        // foudContacts = userContacts;
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
        color: Color(0xff181818),
        child: FutureBuilder(
          future: ContactServices().getContactsByUserId(
              UserController.instance.user.id, AuthController.instance.token),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView.builder(
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
                      title: Text(
                          isControllerEmpty()
                              ? "${snapshot.data[index].name}"
                              : "${snapshot.data[index].name}",
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text("${snapshot.data[index].phone}",
                          style: TextStyle(color: Colors.white)),
                      onTap: () => {
                        ContactController.instance
                            .addContact(snapshot.data[index]),
                        Navigator.pushNamed(context, '/third')
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
      ),
    );
  }

  void onSearchTextChanged(String text) async {
    setState(() {
      print(searchInputController.text);

      // var foudContacts = userContacts.where((element) =>
      //     element.name.toLowerCase().contains(searchInputController.text));

      // print(foudContacts);
    });
  }

  bool isControllerEmpty() {
    return searchInputController.text == "" ? true : false;
  }
}
