import 'package:sqflite/sqflite.dart';

abstract class BaseDao {
  var TAG = "SQL";
  Database db;

  BaseDao(this.db);
}