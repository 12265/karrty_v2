import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
    getData();
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: getAppBar(mediaQuery, theme),
      body: getBody(context, mediaQuery, theme),drawer: MenuPage(),
    );
  }
Future<List<MarcheModdle>> getData()
async {
  final respende = await ApiClient.client.get(Uri.https(baseUrl, "/api/v1/marketApp/markets"));
  List body = jsonDecode(respende.body);
  List <MarcheModdle> marcheList =  body.map((e) => MarcheModdle.fromJson(e)).toList();
  return marcheList;
}
  PreferredSizeWidget getAppBar(MediaQueryData mediaQuery, ThemeData theme) {
    return AppBar(
      backgroundColor: theme.backgroundColor,
      title: Padding(padding:  EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.25), child: Text("Karrty"),
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
  Widget getBody(
      BuildContext context, MediaQueryData mediaQuery, ThemeData theme) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.size.width * 0.05,
              vertical: mediaQuery.size.height * 0.01),
          child: TextInput("Chercher un marché", textInput, context, mediaQuery,
              Icon(Icons.search), false, theme, 1),
        ),
          FutureBuilder(future: getData(),builder: (context,AsyncSnapshot<List<MarcheModdle>?>snapshot) {
            if (snapshot.hasData) {
              counting(snapshot.data, context);
              return Text(
                "    ${numberOfMarches} Actif marchés",
                style: TextStyle(
                    fontSize: mediaQuery.size.width * 0.05,
                    fontWeight: FontWeight.bold),
              );
            }
            else
              {
                return Text(
                  "    0 Actif marchés",
                  style: TextStyle(
                      fontSize: mediaQuery.size.width * 0.05,
                      fontWeight: FontWeight.bold),
                );
              }
          }
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.02,
        ),
        Container(
          width: double.infinity,
          height: mediaQuery.size.height * 0.76,
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
