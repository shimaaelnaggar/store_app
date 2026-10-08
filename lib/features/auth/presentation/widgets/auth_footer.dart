import 'package:flutter/material.dart';
import 'package:store/features/auth/presentation/widgets/custom_text_button.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  const AuthFooter(
      {Key? key,
      required this.text,
      required this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: text,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }
}
