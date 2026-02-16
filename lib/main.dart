import 'package:flutter/material.dart';
import 'package:remainder/pages/home_page.dart';

void main() {
  runApp(RemainderApp());
}

class RemainderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {HomePage.id: (context) => HomePage()},
      theme: ThemeData(brightness: Brightness.dark),
      home: const HomePage(),
    );
  }
}
