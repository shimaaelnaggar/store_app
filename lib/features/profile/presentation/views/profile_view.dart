import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/di/service_locator.dart';
import 'package:store/core/widgets/app_top_bar.dart';
import 'package:store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:store/features/profile/presentation/bloc/profile_event.dart';
import 'package:store/features/profile/presentation/bloc/profile_state.dart';

import '../../../../core/storage/auth_storage.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<void> _logout(BuildContext context) async {
    try {
      await getIt<AuthStorage>().clearTokens();

      if (!context.mounted) return;

      context.go('/login');
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to log out. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(GetProfileEvent()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                const AppTopBar(title: 'Profile'),
                SizedBox(height: 30.h),
                Expanded(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoadingState ||
                          state is ProfileInitialState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }

                      if (state is ProfileFailureState) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(state.errorMessage),
                              SizedBox(height: 12.h),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ProfileBloc>()
                                      .add(GetProfileEvent());
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is ProfileSuccessState) {
                        final profile = state.profile;

                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 55.r,
                              backgroundColor: AppColors.inputFillColor,
                              backgroundImage: profile.profilePicture != null &&
                                      profile.profilePicture!.isNotEmpty
                                  ? NetworkImage(profile.profilePicture!)
                                  : null,
                              child: profile.profilePicture == null ||
                                      profile.profilePicture!.isEmpty
                                  ? Icon(
                                      Icons.person_outline_rounded,
                                      size: 55.r,
                                      color: AppColors.textSecondaryColor,
                                    )
                                  : null,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              profile.fullName,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimaryColor,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              profile.email,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                            SizedBox(height: 35.h),
                            _buildProfileInfo(
                              icon: Icons.person_outline,
                              title: 'Full Name',
                              value: profile.fullName,
                            ),
                            SizedBox(height: 16.h),
                            _buildProfileInfo(
                              icon: Icons.email_outlined,
                              title: 'Email Address',
                              value: profile.email,
                            ),
                            SizedBox(height: 16.h),
                            _buildOrdersButton(
                              context,
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () => _logout(context),
                                icon: const Icon(Icons.logout_rounded),
                                label: const Text('Logout'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.errorColor,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14.h,
                                  ),
                                  side: const BorderSide(
                                      color: AppColors.errorColor),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.inputBorderColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
            size: 22.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildOrdersButton(
  BuildContext context,
) {
  return InkWell(
    onTap: () => context.push('/my-orders'),
    borderRadius: BorderRadius.circular(12.r),
    child: Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.inputBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.primaryColor,
            size: 22.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'My Orders',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16.r,
            color: AppColors.textSecondaryColor,
          ),
        ],
      ),
    ),
  );
}
