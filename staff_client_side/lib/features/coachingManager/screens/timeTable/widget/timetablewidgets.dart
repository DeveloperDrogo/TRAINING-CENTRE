import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_client_side/colors/colors.dart';

class DayTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const DayTab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? MyColors.secondaryColor
                : AdaptiveTheme.of(context).mode.isDark
                    ? const Color.fromARGB(255, 72, 72, 72)
                    : Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 5),
          child: Text(
            label,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: isSelected ? Colors.white : AdaptiveTheme.of(context).mode.isDark
                    ? Colors.white
                    : Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
