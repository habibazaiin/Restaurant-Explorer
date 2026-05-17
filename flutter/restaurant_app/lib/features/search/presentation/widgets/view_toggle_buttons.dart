import 'package:flutter/material.dart';

class ViewToggleButtons extends StatelessWidget {
  final bool isListMode;
  final VoidCallback onListTap;
  final VoidCallback onMapTap;

  const ViewToggleButtons({
    super.key,
    required this.isListMode,
    required this.onListTap,
    required this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ToggleButton(
          label: 'View as list',
          icon: Icons.list,
          isActive: isListMode,
          onTap: onListTap,
        ),
        const SizedBox(width: 12),
        _ToggleButton(
          label: 'View on map',
          icon: Icons.map_outlined,
          isActive: !isListMode,
          onTap: onMapTap,
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF5A623) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive ? const Color(0xFFF5A623) : const Color(0xFFE0E0E0),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? Colors.white : const Color(0xFF555555),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : const Color(0xFF555555),
              ),
            ),
          ],
        ),
      ),
    );
  }
}