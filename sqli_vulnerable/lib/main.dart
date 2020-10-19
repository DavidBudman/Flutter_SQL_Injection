import 'package:flutter/material.dart';
import 'package:sqli_vulnerable/LoginPage.dart';
import 'package:sqli_vulnerable/CoursesPage.dart';
import 'package:sqli_vulnerable/StudentPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vulnerable',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/student': (context) => StudentPage(),
        '/courses': (context) => CoursesPage()
      }
    );
  }
}