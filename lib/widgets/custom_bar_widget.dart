import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remainder/widgets/custom_icon_widget.dart';

class CustomBarWidget extends StatelessWidget {
  const CustomBarWidget({
    required this.icon,
    this.colorr = Colors.white,
    this.onPressed,
  });
  final IconData icon;
  final Color? colorr;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remainders',
            style: TextStyle(
              color: colorr,
              fontSize: 23,
              fontWeight: FontWeight.w400,
            ),
          ),

          CustomIconhWidget(
            icon: icon,
            iconColor: colorr,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
