import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../adresses/domain/entites/addresses.dart';

class AddressCard extends StatelessWidget {
  final Addresses address;
  final void Function()? onPressed;
  const AddressCard({Key? key, required this.address, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.primaryColor,
                size: 24.r,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '${address.state}, ${address.city}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: const Text('Change'),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${address.street}, ${address.apartment}',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 6.h),
          Text(
            address.phoneNumber,
            style: AppTextStyles.bodyMedium,
          ),
          if (address.notes.trim().isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              address.notes,
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}
