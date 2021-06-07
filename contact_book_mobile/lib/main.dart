import 'package:contact_book_mobile/views/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Contatos',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
