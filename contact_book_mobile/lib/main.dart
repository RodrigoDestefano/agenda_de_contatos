import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/contact_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/views/add_object_view/page/add_object.dart';
import 'package:contact_book_mobile/views/contact_view/page/contact_view.dart';
import 'package:contact_book_mobile/views/home_view/page/home_page.dart';
import 'package:contact_book_mobile/views/login_view/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => ContactController()),
      ],
      child: MaterialApp(
        title: 'Contacts Book',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // All routes of the app
        routes: {
          '/': (context) => Login(),
          Home.routeName: (context) => Home(),
          AddObjectView.routeName: (context) => AddObjectView(),
          '/fourth': (context) => ContactView(),
        },
      ),
    );
  }
}
