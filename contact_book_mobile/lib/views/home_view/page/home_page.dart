import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/views/home_view/page/contacts_tab.dart';
import 'package:contact_book_mobile/views/home_view/widgets/custom_fab.dart';
import 'package:contact_book_mobile/views/home_view/page/groups_tab.dart';
import 'package:flutter/material.dart';

// This file contains the entire page and call your widgets
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              title: Text(
                  "Agenda de Contatos de ${UserController.instance.user.name}"),
              backgroundColor: Color(0xff3fa1ff),
              bottom: TabBar(
                indicatorColor: Color(0xff04559d),
                tabs: [
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.group))
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [ContactsTab(), GroupsTab()],
          ),
          floatingActionButton: CustomFab(),
        ),
      ),
    );
  }
}
