import 'package:flutter/material.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:karttyas/login_page/text_above_text_input.dart';
import 'package:karttyas/login_page/text_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool firstrebuild = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: getBody(context));
  }
  Widget getBody(BuildContext context) {
    print("rebuilded");
    MediaQueryData mediaQuery = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    if(firstrebuild == true) {
      username.text = context.watch<KarrtyProvider>().textInputSaveValues["username"].toString();
      username.selection = TextSelection.fromPosition(
          TextPosition(offset: username.text.length));
      password.text = context.watch<KarrtyProvider>().textInputSaveValues["password"].toString();;
      password.selection = TextSelection.fromPosition(
          TextPosition(offset: password.text.length));
      firstrebuild = false;
    }
    return ListView(
      children: [
        Container(height: mediaQuery.size.height * 0.365,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("Images/Capture.PNG"))),),
        Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(mediaQuery.size.width * 0.1))),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(mediaQuery.size.height * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Text("Bienvenu(e)",
                          style: TextStyle(
                              fontSize: mediaQuery.size.width * 0.1))),
                  Center(
                      child: Text(
                    "à votre assitant de l'attachement",
                    style: TextStyle(fontSize: mediaQuery.size.width * 0.05),
                  )),
                  SizedBox(height: mediaQuery.size.height * 0.03),
                  TextAboveInputText(mediaQuery, "Nom d'utilisateur"),
                  TextInput(
                      "username",
                      username,
                      context,
                      mediaQuery,
                      Icon(Icons.account_box_rounded,
                          color: theme.primaryColor),
                      false,
                      theme,0),
                  TextAboveInputText(mediaQuery, "Mote de passe"),
                  TextInput(
                      "password",
                      password,
                      context,
                      mediaQuery,
                      Icon(
                        Icons.lock,
                        color: theme.primaryColor,
                      ),
                      true,
                      theme,0),
                  Row(children: [IconButton(onPressed: (){
                    context.read<KarrtyProvider>().rememberMe();
                  }, icon: context.watch<KarrtyProvider>().rememberMeBool == false ?Icon(Icons.check_box_outline_blank):Icon(Icons.check_box,color: Colors.blue,)),Text("se souvenir de moi")]),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: mediaQuery.size.height * 0.04),
                    child: SizedBox(
                      width: double.infinity,
                      height: mediaQuery.size.height * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mediaQuery.size.width *0.2)),
                              primary: theme.primaryColor),
                          onPressed: () {
                            if (username.text.isEmpty == false && password.text.isEmpty == false) {
                              context.read<KarrtyProvider>().karrtyLogin(username.text, password.text);
                            }
                          },
                          child: Text(
                            "SE CONNECTER",
                            style: TextStyle(
                                fontSize: mediaQuery.size.height * 0.02),
                          )),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
