import '../helpers/custom_colors.dart';
import '../helpers/functions.dart';
import '../screens/mobile/video_call.dart';
import '../widgets/video.dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildAppBar(BuildContext context, friendName, friendImageUrl) {
  return AppBar(
    backgroundColor:
        isMobile() ? Theme.of(context).primaryColor : Colors.grey[50],
    automaticallyImplyLeading: false,
    titleSpacing: 0.0,
    title: Row(
      children: [
        isMobile()
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back))
            : SizedBox(
                width: 10.0,
              ),
        CircleAvatar(
          backgroundImage: NetworkImage(friendImageUrl),
          radius: 20.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text(
            friendName,
            maxLines: 1,
            overflow: TextOverflow.clip,
            softWrap: true,
            style: TextStyle(
              fontSize: 15.0,
              color: isMobile() ? Colors.white : CustomColors.primary,
            ),
          ),
        )
      ],
    ),
    actions: [
      IconButton(
          color: isMobile() ? Colors.white : CustomColors.primary,
          onPressed: () {
            // showDialog(context: context, builder: (builder)=>{return videoDailog();})
            if (isMobile()) {
              Get.to(VideoCall());
              // print('Platform: ${Platform.operatingSystem}');
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext ctx) => VideoCall()));

            } else {
              Get.dialog(
                videoDailog(),
                barrierDismissible: false,
                barrierColor: Colors.transparent,
              );
              // showDialog(
              //     context: context,
              //     builder: (builder) {
              //       return videoDailog(context);
              //     },
              //     barrierDismissible: false,
              //     barrierColor: Colors.transparent,
              //     routeSettings: RouteSettings(name: 'video-call'));
            }
          },
          icon: Icon(Icons.video_call)),
      IconButton(
          color: isMobile() ? Colors.white : CustomColors.primary,
          onPressed: () {
            print('To initiate audio call');
          },
          icon: Icon(Icons.call)),
      IconButton(
          color: isMobile() ? Colors.white : CustomColors.primary,
          onPressed: () {
            print('To initiate more option as popover');
          },
          icon: Icon(Icons.more_vert))
    ],
  );
}
