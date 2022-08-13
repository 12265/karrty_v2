import 'package:flutter/material.dart';
import 'package:karttyas/karrty_provider.dart';
import 'package:karttyas/march%C3%A9_informations_page/march%C3%A9_informations.dart';
import 'package:karttyas/personal_informations/personal_informations.dart';
import 'package:provider/provider.dart';

class MarcheComponents extends StatelessWidget {
  String tittle;
  final id;
  String owner;
  int index;

  MarcheComponents(this.tittle, this.id, this.owner, this.index);

  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        Divider(color: Colors.grey),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height:
                      id is AssetImage ? mediaQuery.size.width * 0.15 : null,
                  width: id is AssetImage ? mediaQuery.size.width * 0.15 : null,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.backgroundColor,
                      image: id is AssetImage
                          ? const DecorationImage(
                              image: AssetImage("Images/images.jpg"),
                              fit: BoxFit.cover)
                          : null),
                  child: id is String
                      ? Container(
                          width: mediaQuery.size.width * 0.15,
                          height: mediaQuery.size.height * 0.07,
                          child: FittedBox(
                              child: Padding(
                                padding: EdgeInsets.all(mediaQuery.size.width * 0.04),
                                child: Text(id,
                                    style: TextStyle(
                                        fontSize: mediaQuery.size.width * 0.1,
                                        color: Colors.white)),
                              )))
                      : null),
              SizedBox(width: mediaQuery.size.width * 0.05),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: mediaQuery.size.width * 0.6,alignment: Alignment.topLeft,
                    child: Text(overflow: TextOverflow.fade,
                      tittle,maxLines: 1,
                      style: TextStyle(fontSize: mediaQuery.size.width * 0.05),
                    ),
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.01),
                  Container(width: mediaQuery.size.width * 0.6,child: Text(owner,maxLines: 1, style: TextStyle(color: Colors.black38)))
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        if (id is String) {
                          context.read<KarrtyProvider>().changeMarchIndex(index);
                          return MarcheInformation(index);
                        } else {
                          return PersonalInformation(context.watch<KarrtyProvider>().marcheIndex, index);
                        }
                      }),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: theme.accentColor,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
