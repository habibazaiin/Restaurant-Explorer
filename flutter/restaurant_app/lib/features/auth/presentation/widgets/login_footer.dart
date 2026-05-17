import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../screens/signup_screen.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppStrings.dontHaveAccount, style: TextStyle(fontSize: 13)),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SignupScreen()),
          ),
          child: const Text(
            AppStrings.signup,
            style: TextStyle(
              color: Color(0xFFF5A623),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}