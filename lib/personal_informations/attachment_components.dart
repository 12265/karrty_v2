import 'package:flutter/material.dart';
import 'package:karttyas/moddles/work_trackers_moddle.dart';

class AttachmentComponents extends StatelessWidget {
  List<WorkTrackerModdle> dates;

  AttachmentComponents(this.dates);

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    return ListView.builder(itemBuilder: (context,index)
    {
      return Column(children: [
      Divider(color: Colors.grey),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
        child: Row(children: [
          Text(dates[index].date.toString()),
          Spacer(),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_forward_ios, color: theme.accentColor,))
        ],),
      )
    ],);
  },itemCount: dates.length,
    );}}
