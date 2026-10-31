import 'package:flutter/material.dart';

import '../constants/app_text_styles.dart';

class AppSectionTitle extends StatelessWidget {
  final String title;
  const AppSectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.bodyLarge.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
