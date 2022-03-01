import '../providers/account_provider.dart';
import '../screens/mobile/account/welcome.screen.dart';
import '../services/socketio_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import '../data/user.dao.dart';

import '../models/user.dart';

class UserController extends GetxController {
  late Rx<UserModel> user;
  late List<UserModel> users;
  UserDao userDB = UserDao();

  insert(user) async {
    await userDB.insert(user);
    await getAll();
  }

  updateUser(user) async {
    var updated = await userDB.update(user);
    await this.getAll();
    return updated;
  }

  delete(user) async {
    await userDB.delete(user);
  }

  getAll() async {
    try {
      var found = await userDB.getAllSortedByName();
      user = found.first.obs;
      users = found.obs;
    } catch (e) {
      print("Db Error: ");
      Get.to(Welcome());
    }
  }

  getById(userId) async {
    var found = await userDB.getById(userId);
    user = found.obs;
  }

  getContacts() async {
    print('Reaching get contacts');
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts();
      print("contacts: $contacts");
      // accountService.verifyContacts(contacts);
      return contacts;
    }
  }
}
