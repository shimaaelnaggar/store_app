import 'package:flutter/material.dart';
import 'package:store/core/constants/app_spacing.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class PaginationButtons extends StatelessWidget {
  final int currentPage;
  final int totalCount;
  final int pageSize;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final void Function(int page) onPageChanged;
  const PaginationButtons({
    Key? key,
    required this.currentPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.onPageChanged,
    required this.totalCount,
    required this.pageSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int totalPages = (totalCount / pageSize).ceil();
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: hasPreviousPage
                    ? () => onPageChanged(currentPage - 1)
                    : null,
                child: const Text('Previous'),
              ),
              const SizedBox(width: AppSpacing.sm),
              ...List.generate(
                totalPages,
                (index) {
                  final page = index + 1;
                  final bool isSelected = page == currentPage;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    child: InkWell(
                      onTap: isSelected ? null : () => onPageChanged(page),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$page',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isSelected ? AppColors.secondaryColor : null,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: AppSpacing.sm),
              TextButton(
                onPressed:
                    hasNextPage ? () => onPageChanged(currentPage + 1) : null,
                child: const Text('Next'),
              ),
            ],
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          Text(
            'Showing ${((currentPage - 1) * pageSize) + 1}'
            ' of $totalCount products',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
