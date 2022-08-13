import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karttyas/http_files/http_client.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:karttyas/moddles/contracts_moddle.dart';
import 'package:karttyas/moddles/quotations_moddle.dart';
import 'package:karttyas/moddles/work_trackers_moddle.dart';
import 'package:provider/provider.dart';

import '../http_files/karrty_url.dart';

class NewWorkTracker extends StatelessWidget {
  int marketIndex;
  int contractIndex;
  List<TextEditingController> textInput = [];
  WorkTrackerModdle workTrackerModdle = WorkTrackerModdle(date: DateFormat("yyyy-MM-dd").format(DateTime.now()),workTrackerContents: []);
  NewWorkTracker(this.marketIndex, this.contractIndex);

  Widget textWidget(MediaQueryData mediaQuery, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: mediaQuery.size.width * 0.04),
      ),
    );
  }

  Future<List<QuotationsModdle>> getData(String? id) async {
    final responde = await ApiClient.client.get(
        Uri.https(baseUrl, "/api/v1/contractApp/contracts/$id/quotations"));
    List body = jsonDecode(responde.body);
    List<QuotationsModdle> quotationModdle = body.map((e) => QuotationsModdle.fromJson(e)).toList();
    return quotationModdle;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: getAppBar(theme),
      body: getBody(mediaQuery, context, theme),
      backgroundColor: theme.backgroundColor,
    );
  }

  PreferredSizeWidget getAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      title: const Text("Karrty"),
      centerTitle: true,
      backgroundColor: theme.backgroundColor,
    );
  }
  BorderSide textBorderColor(BuildContext context,int index,ThemeData theme)
  {
    if(context.watch<KarrtyProvider>().errorIndex == index && context.watch<KarrtyProvider>().textHasError)
      {
        context.read<KarrtyProvider>().textHasError = false;
        return BorderSide(color: Colors.red,width: 5);
      }
    else
      {
        return BorderSide(color: theme.primaryColor);
      }
  }
bool textHasNoError(String text)
{
  bool a = double.tryParse(text) != null;
  return a;
}
  Widget getBody(
      MediaQueryData mediaQuery, BuildContext context, ThemeData theme) {
    ContractsModdle contractsModdle =
        context.watch<KarrtyProvider>().contractsModdle[contractIndex];
    return ListView(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.05),
        child: Center(
            child: Container(
          width: double.infinity,
          height: mediaQuery.size.height * 0.2,
          margin:
              EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05),
          child: FittedBox(
            child: Text(
              "MARCHÉ:\n${context.watch<KarrtyProvider>().marcheModdle[marketIndex].name}marketIndex\n\n SOUS-TRAITANT\n ${contractsModdle.market}",
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
          height: mediaQuery.size.height * 0.59,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(mediaQuery.size.width * 0.1)),
              color: Colors.white),
          child: Padding(
            padding: EdgeInsets.only(
              top: mediaQuery.size.height * 0.04,
            ),
            child: FutureBuilder(
                future: getData(contractsModdle.id),
                builder:
                    (context, AsyncSnapshot<List<QuotationsModdle>> snapshot) {
                      workTrackerModdle.workTrackerContents!.clear();
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (index < snapshot.data!.length) {
                          textInput.add(TextEditingController());
                          workTrackerModdle.workTrackerContents!.add(Contents(quotationId: snapshot.data![index].id,quantity: 0));
                          return Column(children: [
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: mediaQuery.size.height * 0.01),
                              child: Row(children: [
                                textWidget(mediaQuery,
                                    "${snapshot.data![0].description}"),
                                Spacer(),
                                Container(
                                    height: mediaQuery.size.height * 0.06,
                                    width: mediaQuery.size.width * 0.25,
                                    child: TextField(controller: textInput[index],keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "00.00",
                                        labelStyle: TextStyle(color: Colors.black),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:BorderSide(
                                                color: theme.primaryColor)),
                                        isDense: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                mediaQuery.size.width * 0.02),
                                            borderSide: textBorderColor(context, index,theme)),
                                      ),
                                    )),
                                textWidget(
                                    mediaQuery, "${snapshot.data![0].unity}")
                              ]),
                            ),
                          ]);
                        } else {
                          return Container(
                            margin: index >= 5
                                ? EdgeInsets.symmetric(
                                    horizontal: mediaQuery.size.width * 0.1,
                                    vertical: mediaQuery.size.height * 0.03)
                                : EdgeInsets.only(
                                    left: mediaQuery.size.width * 0.1,
                                    right: mediaQuery.size.width * 0.1,
                                    bottom: mediaQuery.size.height * 0.025,
                                    top: mediaQuery.size.height *
                                        (0.37 -
                                            (snapshot.data!.length * 0.1 -
                                                0.1))),
                            height: mediaQuery.size.height * 0.05,
                            color: Colors.white54,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            mediaQuery.size.width * 0.2)),
                                    primary: theme.primaryColor),
                                onPressed: () async {
                                  for(int i=0; i < workTrackerModdle.workTrackerContents!.length; i++) {
                                      if(textHasNoError(textInput[i].text) == true) {workTrackerModdle.workTrackerContents![i].quantity = num.parse(textInput.elementAt(i).text);
                                      }
                                      else {context.read<KarrtyProvider>().textHasAnError(i);}
                                    }
                                  if(context.read<KarrtyProvider>().textHasError == false)
                                    {
                                      final responde = await ApiClient.client.post(Uri.https(baseUrl, "/api/v1/contractApp/contracts/${Provider.of<KarrtyProvider>(context,listen: false).contractsModdle[contractIndex].id}/workTrackers"),body: jsonEncode(workTrackerModdle));
                                    print(responde.statusCode);
                                    }
                                  },
                                child: Text(
                                  "ENREGISTRER",
                                  style: TextStyle(
                                      fontSize: mediaQuery.size.height * 0.02),
                                )),
                          );
                        }
                      },
                      itemCount: snapshot.data!.length + 1,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ))
    ]);
  }
}
