import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:karttyas/actif_marches_page/actif_marches.dart';
import 'package:karttyas/login_page/login_page.dart';
import 'package:provider/provider.dart';
import 'karrty_provider.dart';

main() {
  runApp(ChangeNotifierProvider(
      create: (_) => KarrtyProvider(), child: MaterialApp(debugShowCheckedModeBanner: false,home: MyApp(),theme: ThemeData(primaryColor: const Color.fromRGBO(79, 70, 229,1.0),hintColor: Colors.grey,accentColor: Colors.black,backgroundColor: Color.fromRGBO(30, 41, 59, 1.0),scaffoldBackgroundColor: Colors.grey[100]))));
}

class MyApp extends StatelessWidget {
  bool appJustLunched = true;
  void rememberMeChecking() async
  {
    final storage = FlutterSecureStorage();
    if(await storage.read(key: "remember me") == "false")
    {
      storage.deleteAll();
    }
    appJustLunched = false;
  }
  Widget build(BuildContext context) {
    if(appJustLunched == true) {
      rememberMeChecking();
    }
    context.watch<KarrtyProvider>().localStorage;
    return FutureBuilder(
            future: context.read<KarrtyProvider>().firstLogin(),
            builder: (context,AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return ActifMarches();
              } else if(snapshot.hasData && snapshot.data == false){
                return LoginPage();
              }
              else
                {
                  return Scaffold(body:Center(child: CircularProgressIndicator()));
                }
            });
  }
}
