import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
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
                  SizedBox(height: 70.h),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("Images/images.jpg"),
                            fit: BoxFit.fitHeight)),
                    width: 200.w,
                    height: isLandScape == false ? 150.h:200.h,
                  ), Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 40.h),
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(snapshot.data.toString(),style: const TextStyle(color: Colors.white)),),
                )],
              )
              );
            }
              else {
                return Center(child: CircularProgressIndicator());
              }
            }
            ),Spacer(),TextButton(onPressed: ()=> context.read<KarrtyProvider>().disconnect(), child: Row(children: [Icon(Icons.arrow_circle_left_outlined,color: theme.accentColor,),Text("Déconnecter",style: TextStyle(color: Colors.red,fontSize: isLandScape == false ? 29.sp : 14.sp),)],))
          ],
        ),
      ),
    );
  }
}
