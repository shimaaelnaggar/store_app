import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/helper/validators.dart';
import 'package:store/features/auth/presentation/widgets/auth_header.dart';
import 'package:store/features/auth/presentation/widgets/custom_divider.dart';

import '../../../../core/constants/app_colors.dart';
import 'custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/register.dart';
import '../bloc/register/register_bloc.dart';
import '../bloc/register/register_event.dart';
import '../bloc/register/register_state.dart';
import 'auth_footer.dart';
import 'auth_social_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthHeader(
            text: 'Create Account',
            subText: 'Sign up to start Shopping with us',
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: firstNameController,
                  hintText: 'First Name',
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: validateName,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: validateName,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            controller: emailController,
            hintText: 'Email Address',
            inputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: validateEmail,
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: AppColors.textSecondaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            inputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            validator: validatePassword,
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: AppColors.textSecondaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: obscureConfirmPassword,
            inputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: (value) {
              return validateConfirmPassword(
                value,
                passwordController.text,
              );
            },
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: AppColors.textSecondaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              icon: Icon(
                obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (BuildContext context, RegisterState state) {
                return state is RegisterLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : CustomElevatedButton(
                        text: 'Create Account',
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final register = Register(
                            email: emailController.text.trim(),
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            password: passwordController.text,
                          );

                          context.read<RegisterBloc>().add(
                                CreateAccountEvent(register: register),
                              );
                        },
                      );
              },
            ),
          ),
          SizedBox(height: 20.h),
          const CustomDivider(),
          SizedBox(height: 20.h),
          const AuthSocialButton(),
          SizedBox(height: 24.h),
          AuthFooter(
            text: 'Already have an account? ',
            buttonText: 'Login',
            onPressed: () => context.push('/login'),
          ),
        ],
      ),
    );
  }
}
