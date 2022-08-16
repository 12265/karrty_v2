import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:provider/provider.dart';

class TextInput extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  BuildContext context;
  Icon iconData;
  bool obscureText;
  ThemeData theme;
  int index;
  List<String> names = ["omar", "M-101"];
  FocusNode focus = FocusNode();

  TextInput(this.labelText, this.controller, this.context,
      this.iconData, this.obscureText, this.theme, this.index);

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    print(isLandscape);
    return Container(
      height: isLandscape == false ? 90.h: 200.h,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: TextField(
          obscureText: obscureText,
          onChanged: (val) {
            if (labelText == "password") {
              context
                  .read<KarrtyProvider>()
                  .textInputSaveValue("password", val,controller.selection.base.offset.toString());
            } else if (labelText == "username") {
              context
                  .read<KarrtyProvider>()
                  .textInputSaveValue("username", val,controller.selection.base.offset.toString());
            } else if (labelText == "Chercher un marché") {
              context.read<KarrtyProvider>().textInputSaveValue("marché", val,controller.selection.base.offset.toString());
            } else if (labelText == "Chercher un sous-traitant") {
              context
                  .read<KarrtyProvider>()
                  .textInputSaveValue("sous-traitant", val,controller.selection.base.offset.toString());
            }
          },
          controller: controller,
          decoration: InputDecoration(
              isDense: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.sp),
                  borderSide: BorderSide(color: theme.primaryColor)),
              labelText: labelText,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.primaryColor)),
              prefixIcon: index == 0 ? iconData : null,
              suffixIcon: index == 1 ? iconData : null)),
    );
  }
}
