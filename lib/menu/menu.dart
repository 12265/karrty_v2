import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  final localStorage = FlutterSecureStorage();

  Future<String?> username()async
  {
    final name = localStorage.read(key: "username");
    return name;
  }

  Widget build(BuildContext context) {
    final mediaQeruy = MediaQuery.of(context);
    final theme = Theme.of(context);
    return SafeArea(
      child: Drawer(
        elevation: 5,
        child: Column(
          children: [
            FutureBuilder(future: username(), builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: theme.backgroundColor,
                  width: double.infinity,
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                  SizedBox(height: mediaQeruy.size.height * 0.04),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("Images/images.jpg"),
                            fit: BoxFit.cover)),
                    width: mediaQeruy.size.width * 0.2,
                    height: mediaQeruy.size.height * 0.08,
                  ), Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: mediaQeruy.size.height * 0.04),
                  child: FittedBox(
                      child: Text(snapshot.data.toString(),style: TextStyle(color: Colors.white)),
                  fit: BoxFit.cover,),
                )],
              )
              );
            }
              else {
                return Center(child: CircularProgressIndicator());
              }
            }
            ),Spacer(),TextButton(onPressed: ()=> context.read<KarrtyProvider>().disconnect(), child: Row(children: [Icon(Icons.arrow_circle_left_outlined,color: theme.accentColor,),Text("Déconnecter",style: TextStyle(color: Colors.red,fontSize: mediaQeruy.size.width * 0.04),)],))
          ],
        ),
      ),
    );
  }
}
