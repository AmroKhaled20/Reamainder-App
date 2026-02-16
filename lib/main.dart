import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/pages/edit_page.dart';
import 'package:remainder/pages/home_page.dart';
import 'package:remainder/widgets/custom_reminder_card_widget.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ReminderModelAdapter());

  await Hive.openBox<ReminderModel>(kReminderBox);
  runApp(RemainderApp());
}

class RemainderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.id: (context) => HomePage(),
        EditPage.id: (context) => EditPage(),
      },
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
      home: const HomePage(),
    );
  }
}
