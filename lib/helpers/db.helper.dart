import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:uzum/models/user.dart';

class DbHelper {
  String dbPath = "uzumdb";
  DatabaseFactory databaseFactory = databaseFactoryIo;
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
