import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToastText extends StatelessWidget {
  bool noErrors;
  String text;

  ToastText(this.noErrors, this.text);

  @override
  Widget build(BuildContext context) {
    if (noErrors == false) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius:
                BorderRadius.all(Radius.circular(40.h))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.check), Text(text)],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        width: 600.w,
        decoration: BoxDecoration(color:Colors.black,
            borderRadius: BorderRadius.all(
                Radius.circular(40.h))),
        child: Text(
            text,style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
      );
    }
  }
}
