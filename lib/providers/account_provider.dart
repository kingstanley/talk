import '../controllers/user.controller.dart';
import '../data/user.dao.dart';
import '../helpers/functions.dart';
import '../models/user.dart';
import '../providers/socket_provider.dart';
import '../screens/home_screen.dart';
import '../screens/mobile/account/otp.screen.dart';
import '../services/socketio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountProvider extends GetConnect {
  // Get request
  getUser(String phone) =>
      get('$apiUrl' + 'api/user/$phone').then((value) async {
        if (value.body != null) {
          debugPrint(
              'user has active mobile device! notify the device via message and verify second device ${value.body}');
          // user
          Get.to(Otp('', phone, false));
        } else {
          Get.to(Otp('', phone, true));
        }
      }).catchError((onError) {
        print('Error checking user');
      });
  Future<Response> getAllUsers() => get('$apiUrl' + 'api/user/listusers');
  Future<Response> getMessage() => get(apiUrl);
  UserController userController = Get.put(UserController());
  // Post request
  createUser(user, context) async {
    final device = await getDeviceInfo();
    // debugPrint("$device");
    post('$apiUrl' + 'api/user/create', {
      'Phone': user.phoneNumber,
      "IsPhoneVerified": true,
      "Devices": device
    }).then((response) async {
      var data = response.body;
      debugPrint("User from Api: ${data}");
      // var user = json.decode(response.body);
      if (data['Phone'] != null) {
        await userController
            .insert(UserModel(data['Phone'], '', '', '', '', '', '',
                data['Devices'], userSocket.id.toString()))
            .then((value) {
          Get.to(HomeScreen());
          debugPrint('user saved in Phone:.. ${value.toString()}');
        });
      }
      // if (data['message'] != null) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     padding: EdgeInsets.only(right: 50, left: 50),
      //     content: Text(
      //       'You already have an active mobile device. We are sending a token to the device for verification on your new device',
      //       style: TextStyle(),
      //     ),
      //   ));
      //   userSocket.emit('gettoken', user['phoneNumber']);
      // }
      //  else {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     padding: EdgeInsets.only(right: 50, left: 50),
      //     content: Text(
      //       'Sorry, Error occured! Please try again. No response from the server: ',
      //       style: TextStyle(),
      //     ),
      //   ));
      // }
    }).catchError((onError) {
      debugPrint('Api error: $onError');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: EdgeInsets.only(right: 50, left: 50),
        content: Text(
          'Sorry, api Error occured! Please try again $onError ',
          style: TextStyle(),
        ),
      ));
    });
  }

  // Post request with File
  Future<Response<UserModel>> postCases(List<int> image) {
    final form = FormData({
      'file': MultipartFile(image, filename: 'avatar.png'),
      'otherFile': MultipartFile(image, filename: 'cover.png'),
    });
    return post('$apiUrl/api/upload', form);
  }

  void verifyDeviceApi(String smsCode, String phone, context) {
    post(apiUrl + '/api/user/verifydevice', {smsCode, phone}).then((value) {
      var user = value.body;
      if (user['Phone'] != null) {
        // Phone and device is verified
        Get.to(HomeScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          padding: EdgeInsets.only(right: 50, left: 50),
          content: Text(
            'Sorry, invalid OTP ',
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
    });
  }

  verifyContacts(contacts) {
    // post(apiUrl + '/api/user/verifycontacts', contacts).then((value) {
    //   print('Verified contacts: ' + value.body.length);
    // });
  }
}
