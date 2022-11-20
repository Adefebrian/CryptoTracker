import 'package:miniproject/view/constant/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  TextEditingController? controller;
  final String? hint;
  final bool readOnly;
  CustomTextfield({
    this.controller,
    this.readOnly = false,
    this.hint,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).cardColor
          // color: Colors.grey[100],
          ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: primaryColor,
              )),
        ),
      ),
    );
  }
}
