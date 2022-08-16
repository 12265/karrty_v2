import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:karttyas/moddles/work_trackers_moddle.dart';

class AttachmentComponents extends StatelessWidget {
  List<WorkTrackerModdle> dates;

  AttachmentComponents(this.dates);

  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListView.builder(itemBuilder: (context,index)
    {
      final date = DateFormat("dd-MM-yyyy").format(DateTime.parse(dates[index].date.toString()));
      return Column(children: [
      Divider(color: Colors.grey),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(children: [
          Text(date),
          Spacer(),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_forward_ios, color: theme.accentColor,))
        ],),
      )
    ],);
  },itemCount: dates.length,
    );}}
