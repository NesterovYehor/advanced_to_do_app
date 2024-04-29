import 'package:advanced_to_do_app/themes/theme.dart';
import 'package:flutter/material.dart';

class BottomSheetBtn extends StatelessWidget {
  const BottomSheetBtn({super.key, required this.color, required this.lable, required this.onTap, required this.isClose});

  final Color color;
  final String lable;
  final Function()? onTap;
  final bool isClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: isClose ? Colors.grey : color
          )
        ),
        child: Center(
          child: Text(lable, style: isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),),
        ),
      ),
    );
  }
}