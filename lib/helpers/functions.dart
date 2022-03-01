import '../providers/socket_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:universal_platform/universal_platform.dart';

var myDeviceInfo = {
  "DeviceId": '',
  "DeviceName": '',
  "DevicePlatform": '',
  "OsVersion": '',
  //"RegisteredOn": DateTime.now(),
  "SocketId": ''
}.obs;

bool isMobile() {
  if (UniversalPlatform.isWeb) {
    return false;
  } else {
    return UniversalPlatform.isAndroid || UniversalPlatform.isIOS;
  }
}

bool isDesktop() =>
    UniversalPlatform.isWindows ||
    UniversalPlatform.isLinux ||
    UniversalPlatform.isMacOS ||
    UniversalPlatform.isWeb;
// return MediaQuery.of(context).size.width < 1000;

isMediumScreen() {
  return Get.width < 1000 && Get.width > 670;
}

// bool isMobile() {
//   if (Get.width <= 570) {
//     debugPrint('Its mobile screen');
//     return true;
//   } else {
//     debugPrint('Its Desktop screen');
//     return false;
//   }
// }

getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (UniversalPlatform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.toMap()}'); // e.g. "Moto G (4)"
    myDeviceInfo.value = {
      "DeviceId": androidInfo.id.toString(),
      "DeviceName": androidInfo.model.toString(),
      "DevicePlatform": 'Android',
      "OsVersion": androidInfo.version.release.toString(),
      // "RegisteredOn": DateTime.now(),
      "SocketId": userSocket.id.toString()
    };
    return myDeviceInfo;
  }
  if (UniversalPlatform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.name}'); // e.g. "iPod7,1"

    myDeviceInfo = RxMap({
      'DeviceId': iosInfo.identifierForVendor.toString(),
      'DeviceName': iosInfo.name.toString(),
      'DevicePlatform': iosInfo.systemName.toString(),
      "OsVersion": iosInfo.systemVersion.toString(),
      // 'RegisteredOn': DateTime.now(),
      "SocketId": userSocket.id.toString()
    });
    return myDeviceInfo;
  }

  WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
  print('Running on ${webBrowserInfo.userAgent}'); //

  myDeviceInfo = RxMap({
    'DeviceId': webBrowserInfo.userAgent.toString(),
    'DeviceName': webBrowserInfo.browserName.toString(),
    'DevicePlatform': 'Web',
    "OsVersion": webBrowserInfo.vendor.toString(),
    // 'RegisteredOn': DateTime.now(),
    "SocketId": userSocket.id.toString()
  });
  return myDeviceInfo;
}
