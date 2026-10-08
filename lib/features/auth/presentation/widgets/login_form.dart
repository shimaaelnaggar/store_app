import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/features/auth/domain/entities/login.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/validators.dart';
import 'custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import 'auth_footer.dart';
import 'auth_header.dart';
import 'auth_social_button.dart';
import 'custom_divider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: Image.asset(
                'assets/images/login_illustration.jpg',
                height: 220.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const AuthHeader(
            text: 'Welcome Back!',
            subText:
                'Email Your credentials to access your orders and wishlist',
            textAlign: TextAlign.center,
          ),
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
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (BuildContext context, LoginState state) {
                return state is LoginLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : CustomElevatedButton(
                        text: 'Login',
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final login = Login(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );

                          context.read<LoginBloc>().add(
                                LoginRequestedEvent(login: login),
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
            text: 'Don\'t have an account? ',
            buttonText: 'Sign Up',
            onPressed: () => context.push('/sign-up'),
          ),
        ]));
  }
}
