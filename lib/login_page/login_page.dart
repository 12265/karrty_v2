import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
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
        Container(height: 580.h,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("Images/Capture.PNG"))),),
        Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(80.h))),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w,vertical: 70.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Text("Bienvenu(e)",
                          style: TextStyle(
                              fontSize: 65.sp))),
                  Center(
                      child: Text(
                    "à votre assitant de l'attachement",
                    style: TextStyle(fontSize: 35.sp),
                  )),
                  SizedBox(height: 50.h),
                  TextAboveInputText("Nom d'utilisateur"),
                  TextInput(
                      "username",
                      username,
                      context,
                      Icon(Icons.account_box_rounded,
                          color: theme.primaryColor),
                      false,
                      theme,0),
                  TextAboveInputText("Mote de passe"),
                  TextInput(
                      "password",
                      password,
                      context,
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
                        vertical: 65.h),
                    child: SizedBox(
                      width: double.infinity,
                      height: isLandScape == false ? 82.h:200.h,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.h)),
                              primary: context.watch<KarrtyProvider>().loginLoading == false ?theme.primaryColor: Colors.grey),
                          onPressed: () {
                            if (username.text.isEmpty == false && password.text.isEmpty == false) {
                              context.read<KarrtyProvider>().karrtyLogin(username.text, password.text);
                            }
                          },
                          child: context.watch<KarrtyProvider>().loginLoading == false ? Text("SE CONNECTER",
                            style: TextStyle(
                                fontSize: 32.sp),
                          ):CircularProgressIndicator(color: Colors.white54,)),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
