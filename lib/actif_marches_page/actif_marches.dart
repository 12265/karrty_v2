import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karttyas/actif_marches_page/marche_components.dart';
import 'package:karttyas/http_files/http_client.dart';
import 'package:karttyas/http_files/karrty_url.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:karttyas/login_page/text_input.dart';
import 'package:karttyas/menu/menu.dart';
import 'package:karttyas/moddles/actif_marches_moddle.dart';
import 'package:provider/provider.dart';

class ActifMarches extends StatelessWidget {
  TextEditingController textInput = TextEditingController();
  String textFieldUsed = "";
  int numberOfMarches = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: getAppBar(theme),
      body: getBody(context, theme),drawer: MenuPage(),
    );
  }
Future<List<MarcheModdle>> getData() async {
      final respende = await ApiClient.client.get(
          Uri.https(baseUrl, "/api/v1/marketApp/markets"));
      List body = jsonDecode(respende.body);
      List <MarcheModdle> marcheList = body.map((e) => MarcheModdle.fromJson(e))
          .toList();

      return marcheList;
}
  PreferredSizeWidget getAppBar(ThemeData theme) {
    return AppBar(centerTitle: true,
      backgroundColor: theme.backgroundColor,
      title: Padding(padding:  EdgeInsets.symmetric(horizontal: 150.w), child: Text("Karrty"),
      )
    );
  }
void counting(List <MarcheModdle>? marcheModdle,BuildContext context)
{
  int a =0;
  for(int i =0; i < marcheModdle!.length; i++)
    {
      if(marcheModdle[i].name!.toLowerCase().contains(context.watch<KarrtyProvider>().textInputSaveValues["marché"].toString().toLowerCase()))
        {
          a++;
        }
    }
  numberOfMarches = a;
}
  Widget getBody(BuildContext context, ThemeData theme) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    textInput.text = Provider.of<KarrtyProvider>(context,listen: false).textInputSaveValues["marché"].toString();
    textInput.selection = TextSelection.fromPosition(TextPosition(offset: int.parse(Provider.of<KarrtyProvider>(context,listen: false).textInputSaveValues["marchéCursorPos"]!)));
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: isLandScape == false ? 10.h:50.h),
          child: TextInput("Chercher un marché", textInput, context,
              Icon(Icons.search), false, theme, 1),
        ),
          FutureBuilder(future: getData(),builder: (context,AsyncSnapshot<List<MarcheModdle>?>snapshot) {
            if (snapshot.hasData) {
              counting(snapshot.data, context);
              return Text("    ${numberOfMarches} Actif marchés",
                style: TextStyle(
                    fontSize: isLandScape == false ? 37.sp: 20.sp,
                    fontWeight: FontWeight.bold),
              );
            }
            else
              {
                return Text(
                  "    0 Actif marchés",
                  style: TextStyle(
                      fontSize: isLandScape == false ? 37.sp: 20.sp,
                      fontWeight: FontWeight.bold),
                );
              }
          }
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          width: double.infinity,
          height: 1220.h,
          child: FutureBuilder(
                future: getData(),
                builder:
                    (context, AsyncSnapshot<List<MarcheModdle>?> snapshot) {
                  if (snapshot.hasData) {
              context.read<KarrtyProvider>().hasValue("marcheModdle", snapshot.data);
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [if(snapshot.data![index].name!.toLowerCase()
                          .contains(context
                          .watch<KarrtyProvider>()
                          .textInputSaveValues["marché"]
                          .toString()
                          .toLowerCase()))MarcheComponents(snapshot.data![index].name.toString(),
                          snapshot.data![index].displayId.toString(),
                          snapshot.data![index].owner.toString(), index)
                      ],
                    );
                  }, itemCount: snapshot.data!.length);
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          }))
      ],
    );
  }
}
