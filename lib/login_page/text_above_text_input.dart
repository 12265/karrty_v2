import 'package:flutter/material.dart';

class TextAboveInputText extends StatelessWidget {
  MediaQueryData mediaQuery;
  String text;
  TextAboveInputText(this.mediaQuery, this.text);
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: mediaQuery.size.height *0.005),
      child: Text(text),
    );
  }
}
