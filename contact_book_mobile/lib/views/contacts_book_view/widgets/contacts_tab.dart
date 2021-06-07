import 'package:contact_book_mobile/views/contacts_book_view/page/contacts_book.dart';
import 'package:flutter/material.dart';

class ContactsTab extends StatefulWidget {
  final List<String> list;
  const ContactsTab(this.list);

  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  TextEditingController searchInputController = TextEditingController();
  var foudContacts;

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        foudContacts = list;
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
      body: ListView.builder(
        itemCount:
            isControllerEmpty() ? list.length : foudContacts.toList().length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 30.0,
              child: Text("$index", style: TextStyle(fontSize: 35.0)),
            ),
            title: Text(isControllerEmpty()
                ? "${list[index]}"
                : "${foudContacts.toList()[index]}"),
            subtitle: Text("Subtitle"),
          );
        },
      ),
    );
  }

  void onSearchTextChanged(String text) async {
    setState(() {
      print(searchInputController.text);
      foudContacts = list.where((element) =>
          element.toLowerCase().contains(searchInputController.text));
      print(foudContacts.toList());
    });
  }

  bool isControllerEmpty() {
    return searchInputController.text == "" ? true : false;
  }
}
