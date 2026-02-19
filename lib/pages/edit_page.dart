import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';

import 'package:remainder/widgets/custom_listofdays_widget.dart';
import 'package:remainder/widgets/custom_outline_button_widget.dart';
import 'package:remainder/widgets/custom_textfield_widget.dart';

import '../widgets/custom_daily_checkbox_widget.dart';

class EditPage extends StatelessWidget {
  static String id = 'Edit page';

  const EditPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 260,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 5, 102, 181),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Text(
                  'Reminder',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                height: 600,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 11,
                      spreadRadius: 3,
                      offset: const Offset(4, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reminder Title*',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 5, 102, 181),
                          ),
                        ),
                        //Title feild
                        CustomTextFieldWidget(),
                        const SizedBox(height: 20),
                        Text(
                          'Reminder Date*',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 5, 102, 181),
                          ),
                        ),
                        //Reminder Date
                        CustomTextFieldWidget(),
                        const SizedBox(height: 20),
                        Text(
                          'Note (optional)',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 5, 102, 181),
                          ),
                        ),
                        //Note (optional)
                        CustomTextFieldWidget(minLines: 5, maxLines: 5),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reminder Frequency*',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 5, 102, 181),
                              ),
                            ),
                            CustomDailyCheckboxWidget(),
                          ],
                        ),
                        const SizedBox(height: 5),
                        CustomListofdaysWidget(),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomOutlineButtonWidget(
                              title: 'Save',
                              onTap: () {},
                            ),
                            CustomOutlineButtonWidget(
                              title: 'Clear',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
