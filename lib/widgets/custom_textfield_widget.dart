import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    this.hintText,
    this.controller,
    this.onSaved,
    this.maxLines = 1,
    this.minLines = 1,
    this.textColor,
    this.onChanged,
    super.key,
  });
  final String? hintText;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final int maxLines;
  final int minLines;
  final Color? textColor;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Feild is required';
        } else {
          return null;
        }
      },
      cursorColor: textColor ?? const Color.fromARGB(255, 5, 102, 181),
      style: TextStyle(color: textColor ?? Colors.black),
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      minLines: minLines,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 5, 102, 181),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
