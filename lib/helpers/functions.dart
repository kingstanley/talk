import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

bool isMobile(BuildContext context) {
  if (!kIsWeb &&
      !Platform.isWindows &&
      !Platform.isLinux &&
      !Platform.isMacOS) {
    return true;
  } else {
    return false;
  }

  // return MediaQuery.of(context).size.width < 1000;
}

isMediumScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < 700 &&
      MediaQuery.of(context).size.width > 570;
}

bool isMobileScreen(BuildContext context) {
  if (MediaQuery.of(context).size.width <= 570) {
    debugPrint('Its mobile screen');
    return true;
  } else {
    debugPrint('Its Desktop screen');
    return false;
  }
}
