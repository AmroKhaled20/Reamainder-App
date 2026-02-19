import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/pages/edit_page.dart';
import 'package:remainder/widgets/custom_bar_widget.dart';
import 'package:remainder/widgets/custom_listOfCards_widget.dart';
import 'package:remainder/widgets/custom_reminder_card_widget.dart';

class HomePage extends StatelessWidget {
  static String id = 'Home page';
  const HomePage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomBarWidget(icon: Icons.search),
              const SizedBox(height: 10),
              Expanded(child: CustomListofcardsWidget()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, EditPage.id);
          },

          backgroundColor: const Color.fromARGB(255, 11, 130, 3),
          child: Icon(Icons.add, size: 35),
        ),
      ),
    );
  }
}
