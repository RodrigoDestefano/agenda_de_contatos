import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:contact_book_mobile/core/controllers/people_api_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/helpers/google_login.dart';
import 'package:contact_book_mobile/core/models/user.dart';
import 'package:contact_book_mobile/views/home_view/widgets/contacts_tab.dart';
import 'package:contact_book_mobile/views/home_view/widgets/custom_fab.dart';
import 'package:contact_book_mobile/views/home_view/widgets/groups_tab.dart';
import 'package:google_fonts/google_fonts.dart';

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
              preferredSize: Size.fromHeight(100.0),
              child: AppBar(
                title: Text(
                  args.isGoogleLogin
                      ? "Google Contact's Book"
                      : "${user.name} Contact's Book",
                  style: GoogleFonts.pacifico(
                    color: defaultWhite,
                    fontSize: 25.0,
                  ),
                ),
                backgroundColor: darkBlue,
                bottom: TabBar(
                  indicatorWeight: 1.0,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.person,
                        size: 18.0,
                        color: defaultWhite,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.group,
                        size: 18.0,
                        color: defaultWhite,
                      ),
                    )
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
          backgroundColor: darkBlue,
          title: DefaultText(
            "Alert!",
            fontColor: defaultWhite,
            fontSize: 25.0,
          ),
          content: DefaultText(
            "Do you really want to loggout?",
            fontColor: defaultWhite,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                willPop = false;
                Navigator.pop(context);
              },
              child: DefaultText(
                'No',
                fontSize: 20,
                fontColor: defaultWhite,
              ),
            ),
            TextButton(
                onPressed: () async {
                  try {
                    // If logged with a Google account then sign out
                    if (args.isGoogleLogin)
                      await PeopleApiController.instance.googleSignIn!
                          .signOut();

                    willPop = true;

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } on Exception catch (error) {
                    print(error);
                  }
                },
                child: DefaultText(
                  'Yes',
                  fontSize: 20,
                  fontColor: defaultWhite,
                )),
          ],
        );
      },
    );
  }
}
