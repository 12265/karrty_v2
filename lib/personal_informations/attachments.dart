import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karttyas/http_files/http_client.dart';
import 'package:karttyas/http_files/karrty_url.dart';
import 'package:karttyas/moddles/work_trackers_moddle.dart';
import 'package:karttyas/personal_informations/attachment_components.dart';
import 'package:provider/provider.dart';
import '../karrty_provider.dart';

class Attachments extends StatelessWidget {
  int contractIndex;

  Attachments(this.contractIndex);

  @override
  Future<List<WorkTrackerModdle>> getData(BuildContext context) async {
    final responde = await ApiClient.client.get(Uri.https(baseUrl, "/api/v1/contractApp/contracts/${context.watch<KarrtyProvider>().contractsModdle[contractIndex].id}/workTrackers"));
    List body = jsonDecode(responde.body);
    List<WorkTrackerModdle> workTrackerModdle =
        body.map((e) => WorkTrackerModdle.fromJson(e)).toList();
    return workTrackerModdle;
  }

  Widget build(BuildContext context) {
    getData(context);
    return ListView(
      children: [
        SizedBox(
          height: 20.h,
        ),
        FutureBuilder(future: getData(context),builder: (context, AsyncSnapshot<List<WorkTrackerModdle>> snapshot) {
          if (snapshot.hasData) {
            return Text(
              "    ${snapshot.data!.length} Attachements",
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold),
            );
          }
          else
            {
             return Text(
                "    0 Attachements",
                style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold),
              );
            }
        }
        ),
        Container(
            width: double.infinity,
            height: 880.h,
            child: FutureBuilder(future: getData(context),builder: (context, AsyncSnapshot<List<WorkTrackerModdle>> snapshot) {
              if(snapshot.hasData) {
                return AttachmentComponents(snapshot.data!);
              }
              else
                {
                  return Center(child:CircularProgressIndicator());
                }
            },
            ))
      ],
    );
  }
}
