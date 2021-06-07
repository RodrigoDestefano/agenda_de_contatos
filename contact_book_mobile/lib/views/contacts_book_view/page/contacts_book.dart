import 'package:contact_book_mobile/views/contacts_book_view/widgets/contacts_tab.dart';
import 'package:flutter/material.dart';

class ContactsBook extends StatefulWidget {
  const ContactsBook({Key? key}) : super(key: key);

  @override
  _ContactsBookState createState() => _ContactsBookState();
}

List<String> list = ["Joao", "MAaria", "Beala", "Rafa", "rahcle"];

class _ContactsBookState extends State<ContactsBook> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Agenda de Contatos"),
              backgroundColor: Color(0xff3fa1ff),
              bottom: TabBar(
                indicatorColor: Color(0xff04559d),
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ContactsTab(list),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
