import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.hintText,
      this.onChanged,
      this.inputType,
      this.prefixIcon,
      this.obscureText = false})
      : super(key: key);
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: obscureText!,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      style: const TextStyle(
        color: AppColors.textPrimaryColor,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.textSecondaryColor,
          fontSize: 14,
        ),
        prefixIcon: prefixIcon ??
            const Icon(
              Icons.search,
              color: AppColors.textSecondaryColor,
            ),
        filled: true,
        fillColor: AppColors.inputFillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
