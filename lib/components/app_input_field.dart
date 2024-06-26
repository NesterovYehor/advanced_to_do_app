import 'package:advanced_to_do_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({super.key, required this.hint, required this.title, required this.controller, required this.widget});

  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle,),
          Container(
            margin:EdgeInsets.only(top: 8),
            padding:EdgeInsets.only(left: 14),
            height: 52,
            decoration: BoxDecoration(
              border:Border.all(
                color: Colors.grey,
                width: 1
              ),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autocorrect: false,
                    cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.colorScheme.background,
                          width: 0
                        )
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.colorScheme.background,
                          width: 0
                        )
                      ),
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}