import 'package:flutter/material.dart';
import '../screens/mobile/video_call.dart';

videoDailog() {
  return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Align(
          alignment: Alignment.topRight,
          child: Container(width: 700, height: 350, child: VideoCall())));
}
