import 'package:drug_alert_frontend/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final Function onTap;
  final String text;
  LinearGradient? gradient;
  Color? color;
  AppButton.gradient({
    Key? key,
    required this.onTap,
    required this.text,
  })  : gradient = AppColors.gradient,
        super(key: key);

  AppButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = Colors.purple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: GoogleFonts.kanit(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
