import 'package:advanced_to_do_app/themes/theme.dart';
import 'package:flutter/material.dart';

class AppTextBtn extends StatelessWidget {
  const AppTextBtn({super.key, required this.lable, required this.onTap});

  final String lable;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 120,
        decoration: BoxDecoration(
          color: primaryclr,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(lable, style: const TextStyle(color: white),),
        ),
      ),
    );
  }
}