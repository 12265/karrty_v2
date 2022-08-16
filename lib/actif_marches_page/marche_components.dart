import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final theme = Theme.of(context);
    return Column(
      children: [
        Divider(color: Colors.grey),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height:
                      id is AssetImage ? 120.h : null,
                  width: id is AssetImage ? 120.w : null,
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
                          width: isLandScape == false ? 120.w:80.w,
                          height: isLandScape == false ? 120.h: 250.h,
                          child: FittedBox(
                              child: Padding(
                                padding: EdgeInsets.all(20.w),
                                child: Text(id,
                                    style: TextStyle(
                                        fontSize: isLandScape == false ? 30.sp :12.sp,
                                        color: Colors.white)),
                              )))
                      : null),
              SizedBox(width: 20.w),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 450.w,alignment: Alignment.topLeft,
                    child: Text(overflow: TextOverflow.fade,
                      tittle,maxLines: 1,
                      style: TextStyle(fontSize: isLandScape == false ? 32.sp:21.sp),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(width: 450.w,child: Text(owner,maxLines: 1, style: TextStyle(color: Colors.black38)))
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
