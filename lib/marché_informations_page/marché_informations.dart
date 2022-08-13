import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:karttyas/http_files/http_client.dart';
import 'package:karttyas/http_files/karrty_url.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:karttyas/moddles/contracts_moddle.dart';
import 'package:provider/provider.dart';

import '../actif_marches_page/marche_components.dart';
import '../login_page/text_input.dart';

class MarcheInformation extends StatelessWidget {
  int index;
  TextEditingController textInput = TextEditingController();
  bool firstrebuild = true;
  int numberOfMarches = 0;

  MarcheInformation(this.index);

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: getAppBar(theme),
      body: getBody(mediaQuery, context, theme),
      backgroundColor: theme.backgroundColor,
    );
  }

  PreferredSizeWidget getAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      title: Text("Karrty"),
      centerTitle: true,
      backgroundColor: theme.backgroundColor,
    );
  }

  void counting(List<ContractsModdle>? contractModdle, BuildContext context) {
    int a = 0;
    for (int i = 0; i < contractModdle!.length; i++) {
      if (contractModdle[i].market!.toLowerCase().contains(context
          .watch<KarrtyProvider>()
          .textInputSaveValues["sous-traitant"]
          .toString()
          .toLowerCase())) {
        a++;
      }
    }
    numberOfMarches = a;
  }

  Future<List<ContractsModdle>> getData(BuildContext context) async {
    final responde = await ApiClient.client.get(Uri.https(baseUrl,
        "/api/v1/contractApp/markets/${context.watch<KarrtyProvider>().marcheModdle[index].id}/contracts"));
    List body = jsonDecode(responde.body);
    List<ContractsModdle> contractModdle =
        body.map((e) => ContractsModdle.fromJson(e)).toList();
    return contractModdle;
  }

  Widget getBody(
      MediaQueryData mediaQuery, BuildContext context, ThemeData theme) {
    getData(context);
    if (firstrebuild == true) {
      textInput.text = context
          .watch<KarrtyProvider>()
          .textInputSaveValues["sous-traitant"]
          .toString();
      textInput.selection = TextSelection.fromPosition(
          TextPosition(offset: textInput.text.length));
      firstrebuild = false;
    }
    return ListView(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.05),
          child: Center(
              child: Container(
            width: double.infinity,
            height: mediaQuery.size.height * 0.105,
            margin:
                EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.12),
            child: FittedBox(
              child: Text(
                "MARCHÉ:\n${context.watch<KarrtyProvider>().marcheModdle[index].name.toString()}",
                style: TextStyle(
                  fontSize: mediaQuery.size.width * 0.1,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )),
        ),
        Container(
          margin: EdgeInsets.all(mediaQuery.size.width * 0.01),
          width: double.infinity,
          height: mediaQuery.size.height * 0.68,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(mediaQuery.size.width * 0.1)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.all(mediaQuery.size.width * 0.02),
                child: TextInput("Chercher un sous-traitant", textInput,
                    context, mediaQuery, Icon(Icons.search), false, theme, 1),
              ),
              FutureBuilder(
                  future: getData(context),
                  builder: (context,
                      AsyncSnapshot<List<ContractsModdle>?> snapshot) {
                    if (snapshot.hasData) {
                      counting(snapshot.data, context);
                      return Text(
                        "    ${numberOfMarches} sous-traitants",
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      );
                    } else {
                      return Text(
                        "    0 sous-traitants",
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      );
                    }
                  }),
              Container(
                  width: double.infinity,
                  height: mediaQuery.size.height * 0.53,
                  child: FutureBuilder(
                      future: getData(context),
                      builder: (context,
                          AsyncSnapshot<List<ContractsModdle>?> snapshot) {
                        if (snapshot.hasData) {
                          context
                              .read<KarrtyProvider>()
                              .hasValue("ContractsModdle", snapshot.data);
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    if (snapshot.data![index].market!
                                        .toLowerCase()
                                        .contains(context
                                            .watch<KarrtyProvider>()
                                            .textInputSaveValues[
                                                "sous-traitant"]
                                            .toString()
                                            .toLowerCase()))
                                      MarcheComponents(
                                          snapshot.data![index].market
                                              .toString(),
                                          AssetImage("Images/images.jpg"),
                                          snapshot.data![index].field
                                              .toString(),
                                          index),
                                  ],
                                );
                              },
                              itemCount: snapshot.data!.length);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }))
            ],
          ),
        )
      ],
    );
  }
}
