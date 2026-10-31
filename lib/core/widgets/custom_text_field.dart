import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;
  final int? maxLength;
  final bool showCounter;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final int maxLines;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.maxLines = 1,
    this.onChanged,
    this.inputType,
    this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.textInputAction,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.showCounter = true,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      textInputAction: textInputAction,
      cursorHeight: 20.h,
      cursorColor: AppColors.primaryColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: textAlign,
      maxLength: maxLength,
      buildCounter: showCounter
          ? null
          : (
              context, {
              required currentLength,
              required isFocused,
              maxLength,
            }) {
              return null;
            },
      style: TextStyle(
        color: AppColors.textPrimaryColor,
        fontSize: 15.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondaryColor,
          fontSize: 14.sp,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.inputFillColor,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 16.r,
              vertical: 15.r,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.5.w,
          ),
        ),
      ),
    );
  }
}
