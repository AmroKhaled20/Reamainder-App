import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/widgets/custom_daily_checkbox_widget.dart';
import 'package:remainder/widgets/custom_listofdays_widget.dart';
import 'package:remainder/widgets/custom_outline_button_widget.dart';
import 'package:remainder/widgets/custom_textfield_widget.dart';

class CustomAddeditReminderCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reminder Title*', style: TextStyle(color: kEditPage)),
              //Title feild
              CustomTextFieldWidget(),
              const SizedBox(height: 20),
              Text('Reminder Date*', style: TextStyle(color: kEditPage)),
              //Reminder Date
              CustomTextFieldWidget(),
              const SizedBox(height: 20),
              Text('Note (optional)', style: TextStyle(color: kEditPage)),
              //Note (optional)
              CustomTextFieldWidget(minLines: 5, maxLines: 5),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reminder Frequency*',
                    style: TextStyle(color: kEditPage),
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
                  CustomOutlineButtonWidget(title: 'Save', onTap: () {}),
                  CustomOutlineButtonWidget(title: 'Clear', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
