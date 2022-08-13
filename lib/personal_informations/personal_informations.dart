import 'package:flutter/material.dart';
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
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton:FloatingActionButton(backgroundColor: theme.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
          return NewWorkTracker(marcheIndex,contractIndex);
              }));},
        child: Icon(Icons.add, color: Colors.white),
      ),
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

  Widget getBody(
      MediaQueryData mediaQuery, BuildContext context, ThemeData theme) {
    return ListView(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.05),
          child: Center(
              child: Container(
            width: double.infinity,
            height: mediaQuery.size.height * 0.2,
            margin:
                EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05),
            child: FittedBox(
              child: Text(
                "MARCHÉ:\n${context.watch<KarrtyProvider>().marcheModdle[marcheIndex].name.toString()}\n\n SOUS-TRAITANT\n ${context.watch<KarrtyProvider>().contractsModdle[contractIndex].market.toString()}",
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
          child:Attachments(contractIndex),
        )
      ],
    );
  }
}
