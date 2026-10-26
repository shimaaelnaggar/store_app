import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final double horizontalPadding;
  final BoxFit fit;
  final double placeholderIconSize;
  const ProductImage(
      {Key? key,
      required this.imageUrl,
      this.width,
      this.height,
      this.borderRadius = 12,
      this.horizontalPadding = 0,
      this.fit = BoxFit.cover,
      this.placeholderIconSize = 28})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h,
      width: width?.w,
      decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(borderRadius.r)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
              strokeWidth: 2,
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: placeholderIconSize.r,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
