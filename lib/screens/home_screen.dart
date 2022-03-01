import '../controllers/user.controller.dart';
import '../helpers/functions.dart';
import '../models/user.dart';
import '../providers/socket_provider.dart';
import '../screens/mobile/account/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'large/home_screen.large.dart';
import 'mobile/home_screen.mobile.dart';

class HomeScreen extends StatelessWidget {
  final device = getDeviceInfo();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    userController.getAll().then((value) async {
      UserModel user = userController.user.value;
      if (user.phoneNumber.toString().isEmpty) {
        print("user in home: ${userController.user.value.phoneNumber}");
        Get.to(Welcome());
      }
      userSocket.on(
          'updateSocket',
          (data) => {
                userSocket.emit('amonline', {
                  "message": 'am online now',
                  "user": userController.user.value.toMap(),
                  "device": myDeviceInfo
                })
              });
      userSocket.emit('amonline', {
        "message": 'am online now',
        "user": userController.user.value.toMap(),
        "device": myDeviceInfo
      });
    });
    return isMobile() ? HomeScreenMobile() : HomeScreenLarge();
  }
}
