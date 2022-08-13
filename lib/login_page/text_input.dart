import 'package:flutter/material.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:provider/provider.dart';

class TextInput extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  BuildContext context;
  MediaQueryData mediaquery;
  Icon iconData;
  bool obscureText;
  ThemeData theme;
  int index;
  List<String> names = ["omar", "M-101"];
  FocusNode focus = FocusNode();

  TextInput(this.labelText, this.controller, this.context, this.mediaquery,
      this.iconData, this.obscureText, this.theme, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaquery.size.height * 0.06,
      margin: EdgeInsets.symmetric(vertical: mediaquery.size.height * 0.005),
      child: TextField(
          obscureText: obscureText,
          onChanged: (val) {
            if (labelText == "password") {
              context
                  .read<KarrtyProvider>()
                  .textInputSaveValue("password", val);
            } else if (labelText == "username") {
              context
                  .read<KarrtyProvider>()
                  .textInputSaveValue("username", val);
            } else if (labelText == "Chercher un marché") {
              context.read<KarrtyProvider>().textInputSaveValue("marché", val);
            } else if (labelText == "Chercher un sous-traitant") {
              context
                  .read<KarrtyProvider>()
                  .textInputSaveValue("sous-traitant", val);
            }
          },
          controller: controller,
          decoration: InputDecoration(
              isDense: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(mediaquery.size.width * 0.02),
                  borderSide: BorderSide(color: theme.primaryColor)),
              labelText: labelText,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.primaryColor)),
              prefixIcon: index == 0 ? iconData : null,
              suffixIcon: index == 1 ? iconData : null)),
    );
  }
}
