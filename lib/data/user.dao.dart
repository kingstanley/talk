import '../models/user.dart';

import '../models/db.dart';
import 'package:sembast/sembast.dart';

class UserDao {
  static const String USER_STORE_NAME = 'Users';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are User objects converted to Map
  final _USERStore = intMapStoreFactory.store(USER_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(UserModel user) async {
    print('inserting user: ${user.phoneNumber}');
    await _USERStore.add(await _db, user.toMap());
  }

  Future update(UserModel user) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(user.id));
    await _USERStore.update(
      await _db,
      user.toMap(),
      finder: finder,
    );
  }

  Future delete(UserModel user) async {
    final finder = Finder(filter: Filter.byKey(user.id));
    await _USERStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<UserModel>> getAllSortedByName() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('username'),
    ]);

    final recordSnapshots = await _USERStore.find(
      await _db,
      finder: finder,
    ).catchError((onError) {
      print("Get All Error: ${onError.toString()}");
    });

    // Making a List<UserModel> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      UserModel user = UserModel.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      user.id = snapshot.key.toString();
      return user;
    }).toList();
  }

  getById(user) {}
}
