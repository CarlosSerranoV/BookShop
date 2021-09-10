import 'package:bookshop/src/model/books.dart';
import 'package:bookshop/src/pages/loginSingUp/login.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/src/pages/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(child: Login()),
    );
  }
}
