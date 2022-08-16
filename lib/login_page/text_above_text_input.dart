import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextAboveInputText extends StatelessWidget {
  String text;
  TextAboveInputText(this.text);
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Text(text),
    );
  }
}
