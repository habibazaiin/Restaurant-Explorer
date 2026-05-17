import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class LevelDropdown extends StatelessWidget {
  final int? selectedLevel;
  final ValueChanged<int?> onChanged;

  const LevelDropdown({
    super.key,
    required this.selectedLevel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.level,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: selectedLevel,
              isExpanded: true,
              hint: const Text(
                AppStrings.selectLevel,
                style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
              ),
              items: [1, 2, 3, 4]
                  .map((l) => DropdownMenuItem(
                        value: l,
                        child: Text('Level $l'),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}