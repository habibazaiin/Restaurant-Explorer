import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'gender_selector.dart';
import 'level_dropdown.dart';
import 'signup_footer.dart';
import 'signup_header.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _gender = 'male';
  int? _selectedLevel;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedLevel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a level')),
        );
        return;
      }
      context.read<AuthCubit>().signup(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            confirmPassword: _confirmPasswordController.text.trim(),
            gender: _gender,
            level: _selectedLevel!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignupHeader(),
                const SizedBox(height: 28),
                CustomTextField(
                  label: AppStrings.name,
                  hint: AppStrings.enterName,
                  controller: _nameController,
                  validator: Validators.validateRequired,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  label: AppStrings.email,
                  hint: AppStrings.enterEmail,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  label: AppStrings.password,
                  hint: AppStrings.enterPassword,
                  controller: _passwordController,
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  label: AppStrings.confirmPassword,
                  hint: AppStrings.enterConfirmPassword,
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) => Validators.validateConfirmPassword(
                      value, _passwordController.text),
                ),
                const SizedBox(height: 14),
                LevelDropdown(
                  selectedLevel: _selectedLevel,
                  onChanged: (val) => setState(() => _selectedLevel = val),
                ),
                const SizedBox(height: 14),
                GenderSelector(
                  selectedGender: _gender,
                  onChanged: (val) => setState(() => _gender = val),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: AppStrings.signup,
                  isLoading: state is AuthLoading,
                  onPressed: () => _onSignup(context),
                ),
                const SizedBox(height: 20),
                const SignupFooter(),
              ],
            ),
          ),
        );
      },
    );
  }
}