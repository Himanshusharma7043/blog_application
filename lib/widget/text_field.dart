import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/border.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:flutter/material.dart';

class textField extends StatefulWidget {
  const textField({
    required this.controller,
    required this.errorMsg,
    required this.title,
    required this.inputType,
    required this.horizontalMargin,
  });
  final TextEditingController controller;
  final String errorMsg;
  final String title;
  final double horizontalMargin;
  final TextInputType inputType;

  @override
  _textFieldState createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  int textLength = 0;
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: displayHeight(context) * 0.02,
          left: widget.horizontalMargin,
          right: widget.horizontalMargin),
      child: TextFormField(
          style: TextStyle(fontSize: displayHeight(context) * 0.03, color: Colors.black),
          controller: widget.controller,
          onChanged: (value) {
            setState(() {
              textLength = value.length;
            });
          },
          validator: (val) {
            if (val!.isEmpty) {
              return widget.errorMsg;
            } else {
              name = val;
            }
          },
          autofocus: false,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            border: border().editFieldsBorder,
            filled: true,
            fillColor: AppColors().lightwhite,
            contentPadding: EdgeInsets.only(
              top: displayHeight(context) * 0.025,
              bottom: displayHeight(context) * 0.025,
              left: displayWidth(context) * 0.04,
              right: displayWidth(context) * 0.04,
            ),
            hintText: widget.title,
            hintStyle: TextStyle(fontSize: displayHeight(context) * 0.025, color: AppColors().grey),
            focusedErrorBorder: border().editFieldsBorder,
            errorBorder: border().editFieldsBorder,
            disabledBorder: border().editFieldsBorder,
            focusedBorder: border().editFieldsBorder,
            enabledBorder: border().editFieldsBorder,
          )),
    );
  }
}
