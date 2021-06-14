import 'package:contact_book_mobile/core/controllers/people_api_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/helpers/google_login.dart';
import 'package:contact_book_mobile/core/models/user.dart';
import 'package:contact_book_mobile/views/home_view/page/contacts_tab.dart';
import 'package:contact_book_mobile/views/home_view/widgets/custom_fab.dart';
import 'package:contact_book_mobile/views/home_view/page/groups_tab.dart';
import 'package:flutter/material.dart';

// This file contains the entire page and call your widgets
class Home extends StatefulWidget {
  static const routeName = '/second';

  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool willPop = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GoogleLogin;

    User user = UserController.instance.user;

    return Material(
      child: DefaultTabController(
        length: 2,
        child: WillPopScope(
          onWillPop: () async {
            _showDialog(context, args);
            return willPop;
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
                title: Text(args.isGoogleLogin
                    ? "Google Contacts Book"
                    : "${user.name} Contacts Book"),
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
              children: [
                ContactsTab(isGoogleLogin: args.isGoogleLogin),
                GroupsTab()
              ],
            ),
            floatingActionButton: CustomFab(),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, args) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("Do you really want to loggout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                willPop = false;
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  if (args.isGoogleLogin) {
                    await PeopleApiController.instance.googleSignIn!.signOut();
                  }

                  willPop = true;

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } on Exception catch (error) {
                  print(error);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
