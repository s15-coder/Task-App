import 'package:task_app/src/models/user_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDB {
  static final HiveDB _instance = HiveDB._privateConstructor();
  factory HiveDB() => _instance;
  HiveDB._privateConstructor();
  late final Box<User> _userBox;
  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    _userBox = await Hive.openBox<User>('user_box');
  }

  Future setUser(User user) async {
    await _userBox.put(123, user);
  }

  User? getUser() {
    return _userBox.get(123);
  }

  Future deleteUser() async {
    await _userBox.delete(123);
  }
}
