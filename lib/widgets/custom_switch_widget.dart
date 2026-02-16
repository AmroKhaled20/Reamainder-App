import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {
  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: isActive,
        onChanged: (value) {
          setState(() {
            isActive = value;
          });
        },
        activeThumbColor: Colors.white, // لون الدايرة
        activeTrackColor: Colors.blue, // لون الخلفية لما يبقى On
        inactiveTrackColor: Colors.grey.shade400, // لما يبقى Off
      ),
    );
  }
}
