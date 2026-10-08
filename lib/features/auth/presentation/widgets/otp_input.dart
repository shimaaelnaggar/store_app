import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_text_field.dart';

class OtpInput extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const OtpInput({
    Key? key,
    required this.onChanged,
  }) : super(key: key);



  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> controllers;

  late final List<FocusNode> focusNodes;
  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());

  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }

    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    final otp = controllers.map((controller) => controller.text).join();

    widget.onChanged(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) {
          return SizedBox(
            width: 45.w,
            height: 52.h,
            child: CustomTextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              inputType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              showCounter: false,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                onChanged(value, index);
              },
            ),
          );
        },
      ),
    );
  }
}
