import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:karttyas/get_margin_top_height.dart';
import 'package:karttyas/http_files/http_client.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:karttyas/moddles/contracts_moddle.dart';
import 'package:karttyas/moddles/quotations_moddle.dart';
import 'package:karttyas/moddles/work_trackers_moddle.dart';
import 'package:karttyas/personal_informations/toast_text.dart';
import 'package:provider/provider.dart';

import '../http_files/karrty_url.dart';

class NewWorkTracker extends StatelessWidget {
  int marketIndex;
  int contractIndex;
  List<TextEditingController> textInput = [];
  WorkTrackerModdle workTrackerModdle = WorkTrackerModdle(date: DateFormat("yyyy-MM-dd").format(DateTime.now()),workTrackerContents: []);
  NewWorkTracker(this.marketIndex, this.contractIndex);

  Widget textWidget(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600),
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
    final theme = Theme.of(context);
    ContractsModdle contractsModdle = context.watch<KarrtyProvider>().contractsModdle[contractIndex];
    return Padding(
          padding: EdgeInsets.only(
            top: 40.h,
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
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(children: [
                              textWidget(snapshot.data![index].description.toString()),
                              Spacer(),
                              Container(
                                  height: 90.h,
                                  width: 170.w,
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
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: textBorderColor(context, index,theme)),
                                    ),
                                  )),
                              textWidget("${snapshot.data![index].unity}")
                            ]),
                          ),
                        ]);
                      } else {
                        return Container(
                          margin: index >= 5
                              ? EdgeInsets.symmetric(
                              horizontal: 50.w,
                              vertical: 80.h)
                              : EdgeInsets.only(
                              left: 50.w,
                              right: 50.w,
                              bottom: 25.h,
                              top: getMarginTopHeight(snapshot.data!.length).h),
                          height: 70.h,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.h)),
                                  primary: theme.primaryColor),
                              onPressed: () async {
                                for(int i=0; i < workTrackerModdle.workTrackerContents!.length; i++) {
                                  if(textInput[i].text.isEmpty)
                                  {
                                    textInput[i].text = "0";
                                  }
                                  if(textHasNoError(textInput[i].text) == true) {workTrackerModdle.workTrackerContents![i].quantity = num.parse(textInput.elementAt(i).text);
                                  }
                                  else {context.read<KarrtyProvider>().textHasAnError(i);}
                                }
                                if(context.read<KarrtyProvider>().textHasError == false)
                                {

                                  final toast = FToast();
                                  toast.init(context);
                                  final responde = await ApiClient.client.post(Uri.https(baseUrl, "/api/v1/contractApp/contracts/${Provider.of<KarrtyProvider>(context,listen: false).contractsModdle[contractIndex].id}/workTrackers"),body: jsonEncode(workTrackerModdle),encoding: Encoding.getByName("utf-8"));
                                  if(responde.statusCode == 201)
                                  {
                                    toast.showToast(child: ToastText(false,"Attachements a été enregistré"),gravity: ToastGravity.TOP);
                                    context.read<KarrtyProvider>().changeAttachementPageIndex();
                                  }
                                  else if(responde.statusCode == 400)
                                  {
                                    print(responde.body);
                                    final a = jsonDecode(responde.body);
                                    toast.showToast(child: ToastText(true,a["message"]),gravity: ToastGravity.TOP);
                                  }
                                }
                              },
                              child: Text(
                                "ENREGISTRER",
                                style: TextStyle(
                                    fontSize: 24.sp),
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
}
