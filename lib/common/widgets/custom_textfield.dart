// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:apex_assessment/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obSecure;
  final Widget? suffix;
  final String hintText;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.validator,
    required this.obSecure,
    this.suffix,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obSecure,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffix: suffix,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Color(0xffE0E0E0),
            ),
          ),
          contentPadding: const EdgeInsets.all(14),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
