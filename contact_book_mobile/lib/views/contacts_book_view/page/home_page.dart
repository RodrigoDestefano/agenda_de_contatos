import 'package:contact_book_mobile/views/contacts_book_view/widgets/contacts_tab.dart';
import 'package:flutter/material.dart';

// This file contains the entire page and call your widgets
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 2,
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
                  Tab(icon: Icon(Icons.directions_transit))
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [ContactsTab(), Icon(Icons.directions_transit)],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
