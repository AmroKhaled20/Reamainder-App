import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/core/services/notification_service.dart';
import 'package:remainder/models/reminder_model.dart';

class CustomSwitchWidget extends StatefulWidget {
  final ReminderModel reminder;

  const CustomSwitchWidget({required this.reminder, super.key});
  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: widget.reminder.isActive,
        onChanged: (value) async {
          setState(() {
            widget.reminder.isActive = value;
          });
          await widget.reminder.save();

          if (value) {
            await NotificationService.instance.scheduleReminderNotifications(
              widget.reminder,
            );
          } else {
            await NotificationService.instance.cancelReminderNotifications(
              widget.reminder,
            );
          }
        },
        activeThumbColor: Colors.white,
        activeTrackColor: kDayselected,
        inactiveTrackColor: Colors.grey.shade400,
      ),
    );
  }
}
