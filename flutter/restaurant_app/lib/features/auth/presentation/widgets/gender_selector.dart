import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_theme.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onChanged;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '${AppStrings.gender}: ',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        _GenderOption(
          value: 'male',
          label: AppStrings.male,
          groupValue: selectedGender,
          onChanged: onChanged,
        ),
        const SizedBox(width: 16),
        _GenderOption(
          value: 'female',
          label: AppStrings.female,
          groupValue: selectedGender,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String value;
  final String label;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const _GenderOption({
    required this.value,
    required this.label,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            activeColor: AppTheme.primaryColor,
            onChanged: (val) => onChanged(val!),
          ),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}