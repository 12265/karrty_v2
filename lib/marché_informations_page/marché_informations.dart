import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  int numberOfMarches = 0;

  MarcheInformation(this.index);

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: getAppBar(theme),
      body: getBody(context),
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

  Widget getBody(BuildContext context) {
    getData(context);
      textInput.text = Provider.of<KarrtyProvider>(context,listen: false).textInputSaveValues["sous-traitant"].toString();
      textInput.selection = TextSelection.fromPosition(TextPosition(offset: int.parse(Provider.of<KarrtyProvider>(context,listen: false).textInputSaveValues["traitantCursorPos"]!)));
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 85.h),
          child: Center(
              child: Container(
            width: double.infinity,
            height: 170.h,
            margin: EdgeInsets.symmetric(horizontal: 120.w),
            child: FittedBox(
              child: Text(
                "MARCHÉ:\n${context.watch<KarrtyProvider>().marcheModdle[index].name.toString()}",
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          width: double.infinity,
          height: 1095.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25)),
              color: Colors.white),
          child: LayoutBuilder(builder: (context, contrains) {
            return ListView(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: TextInput("Chercher un sous-traitant", textInput,
                      context, Icon(Icons.search), false, Theme.of(context), 1),
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
                              fontSize: 34.sp, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Text(
                          "    0 sous-traitants",
                          style: TextStyle(
                              fontSize: 34.sp, fontWeight: FontWeight.bold),
                        );
                      }
                    }),
                Container(
                    width: double.infinity,
                    height: contrains.maxHeight - (216.h),
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
            );
          }),
        )
      ],
    );
  }
}
