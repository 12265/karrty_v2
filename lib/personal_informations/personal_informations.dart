import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:karttyas/personal_informations/attachments.dart';
import 'package:karttyas/personal_informations/new_work_tracker.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatelessWidget {
  int marcheIndex;
  int contractIndex;
  TextEditingController textInput = TextEditingController();

  PersonalInformation(this.marcheIndex, this.contractIndex);

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: context.watch<KarrtyProvider>().attachementPageIndex ==0 ? FloatingActionButton(backgroundColor: theme.primaryColor,
        onPressed: () {
          context.read<KarrtyProvider>().changeAttachementPageIndex();
        },
        child: Icon(Icons.add, color: Colors.white),
      ):null,
      appBar: getAppBar(theme,context),
      body: getBody(context, theme),
      backgroundColor: theme.backgroundColor,
    );
  }

  PreferredSizeWidget getAppBar(ThemeData theme,BuildContext context) {
    return AppBar(leading:  IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: (){Navigator.pop(context);
          if(context.read<KarrtyProvider>().attachementPageIndex == 1) context.read<KarrtyProvider>().changeAttachementPageIndex();
        }),
      elevation: 0,
      title: const Text("Karrty"),
      centerTitle: true,
      backgroundColor: theme.backgroundColor,
    );
  }

  Widget getBody(BuildContext context, ThemeData theme) {
    return ListView(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: 80.h),
          child: Center(
              child: Container(
            width: double.infinity,
            height: 320.h,
            margin:
                EdgeInsets.symmetric(horizontal: 50.w),
            child: FittedBox(
              child: Text(
                "MARCHÉ:\n${context.watch<KarrtyProvider>().marcheModdle[marcheIndex].name.toString()}\n\n SOUS-TRAITANT\n ${context.watch<KarrtyProvider>().contractsModdle[contractIndex].market.toString()}",
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
          width: double.infinity,
          height: 940.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25)),
              color: Colors.white),
          child: context.watch<KarrtyProvider>().attachementPageIndex == 0 ? Attachments(contractIndex):NewWorkTracker(marcheIndex,contractIndex),
        )
      ],
    );
  }
}
