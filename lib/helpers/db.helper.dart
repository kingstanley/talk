import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:uzum/helpers/functions.dart';

class DbHelper {
  String dbPath = "viadb";
  DatabaseFactory databaseFactory =
      isDesktop() ? databaseFactoryWeb : databaseFactoryIo;
  Future<Database> getDb() async {
    Database db = await databaseFactory.openDatabase(dbPath);
    return db;
  }

  getStore() {
    var store = StoreRef.main();
    return store;
  }

  saveMessage(message) async {
    var store = StoreRef.main();
    final saved = await store.add(await getDb(), message);
    print('${saved}');
  }

  createAccount(user) async {
    var store = StoreRef.main();
    final saved = await store.add(await getDb(), user);
    print('${saved}');
  }
}
