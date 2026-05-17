import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_field.dart';

class LoginFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: AppStrings.email,
          hint: AppStrings.enterEmail,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: AppStrings.password,
          hint: AppStrings.enterPassword,
          controller: passwordController,
          obscureText: true,
          validator: Validators.validatePassword,
        ),
      ],
    );
  }
}