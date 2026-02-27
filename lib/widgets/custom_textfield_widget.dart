import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    this.hintText,
    this.controller,
    this.onSaved,
    this.maxLines = 1,
    this.minLines = 1,
    this.textColor,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.isRequired = true,
    super.key,
  });
  final String? hintText;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final int maxLines;
  final int minLines;
  final Color? textColor;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final bool isRequired;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller?.removeListener(() {
      if (mounted) setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      controller: widget.controller,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: (value) {
        if (!widget.isRequired) return null;
        if (value?.isEmpty ?? true) {
          return 'Feild is required';
        } else {
          return null;
        }
      },
      cursorColor: widget.textColor ?? kEditPage,
      style: TextStyle(color: widget.textColor ?? Colors.black),
      keyboardType: TextInputType.multiline,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      textInputAction: TextInputAction.newline,
      textDirection: isArabic(widget.controller?.text ?? '')
          ? TextDirection.rtl
          : TextDirection.ltr,
      textAlign: isArabic(widget.controller?.text ?? '')
          ? TextAlign.right
          : TextAlign.left,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.textColor ?? kEditPage,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

bool isArabic(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text);
}
