import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/widgets/custom_listofdays_widget.dart';
import 'package:remainder/widgets/custom_switch_widget.dart';

class CustomReminderCardWidget extends StatelessWidget {
  const CustomReminderCardWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(255, 120, 120, 120),
          width: 3,
        ),

        color: kCardColor,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Read Quran',
                  style: TextStyle(
                    color: ktextColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomSwitchWidget(),
              ],
            ),
            const SizedBox(height: 1),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '8:45',
                    style: TextStyle(
                      color: kTimeColor,
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'AM',
                      style: TextStyle(
                        color: kTimeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: const Text(
                'Days :',
                style: TextStyle(
                  color: ktextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 5),
            CustomListofdaysWidget(),
          ],
        ),
      ),
    );
  }
}
