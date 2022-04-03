import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'api_cache.dart';
import 'package:path/path.dart';
//import 'package:sqflite_sqlcipher/sqflite.dart';


class DaoSession {
  static DaoSession? _instance;

  late Database _db;

  late ApiCacheDao apiCacheDao;
  DaoSession._(Database db) {
    this._db = db;
    apiCacheDao = ApiCacheDao(db);
  }

  factory DaoSession(Database db) {
    _instance ??= DaoSession._(db);
    return _instance!;
  }
}


class DbProvider {
  DbProvider._();

  static const DB_VERSION = 1;
  static const DB_NAME = "produchunt.db";

  static final instance = DbProvider._();

  Database? _db;
  DaoSession? _daoSession;

  Future<DaoSession> getDaoSession() async {
    //if the database exists return it and if it's not yet created call initDb() for initializing the database
    if (_db == null) {
      _db = await _initDb();
    }
    if (_daoSession == null) {
      _daoSession = DaoSession(_db!);
    }
    return _daoSession!;
  }

  _initDb() async {
    var directory = (await getApplicationDocumentsDirectory()).path;
    debugPrint("document directory Path : $directory");

    var _path = join(directory, DB_NAME);
    print(_path);
    return await openDatabase(
      _path,
      version: DB_VERSION,
      onOpen: (db) {},
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    debugPrint("_onCreate() -> version: $version");
    await _createAllTables(db);
    debugPrint("Table created");
  }


  Future<void> _createAllTables(Database db) async {
    await ApiCacheDao.createTable(db);
  }
}

