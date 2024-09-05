import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';  // Import the login page

void main() => runApp(SmartClassApp());

class SmartClassApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Class',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),  // Start with the LoginPage
    );
  }
}
