import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class ApiCache {
  final String key;
  final String json;
  final int timestamp;

  ApiCache({
    required this.key,
    required this.json,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'json': json,
      'timestamp': timestamp,
    };
  }

  factory ApiCache.fromMap(Map<String, dynamic> map) {
    return ApiCache(
      key: map['key'] ?? '',
      json: map['json'] ?? '',
      timestamp: map['timestamp'] ?? 0,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ApiCache.fromJson(String source) =>
      ApiCache.fromMap(jsonDecode(source));

  bool get isValid => (json != null && json.isNotEmpty) && timestamp > 0;
}

class ApiCacheDao extends BaseDao {
  static const TABLE_NAME = "tbl_api_cache";
  static const COLUMN_API_KEY = "key";
  static const COLUMN_JSON = "json";
  static const COLUMN_TIMESTAMP = "timestamp";

  ApiCacheDao(Database db) : super(db);

  static List<String> get allColumns {
    return [
      COLUMN_API_KEY,
      COLUMN_JSON,
      COLUMN_TIMESTAMP,
    ];
  }

  static createTable(Database db) async {
    const sql = """
      CREATE TABLE IF NOT EXISTS $TABLE_NAME(
        $COLUMN_API_KEY TEXT NOT NULL PRIMARY KEY,
        $COLUMN_JSON TEXT NOT NULL,
        $COLUMN_TIMESTAMP INTEGER NOT NULL
      )
    """;
    return await db.execute(sql);
  }

  static dropTable(Database db) async {
    const sql = "DROP TABLE IF EXISTS $TABLE_NAME";
    return await db.execute(sql);
  }

  Future<int> upsert(ApiCache apiCache) async {
    return await db.insert(
      TABLE_NAME,
      apiCache.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteAll() async {
    return await db.delete(TABLE_NAME);
  }

  Future<int> delete({required String key}) async {
    return await db.delete(
      TABLE_NAME,
      where: "$COLUMN_API_KEY = ?",
      whereArgs: [key],
    );
  }

  Future<int> updateCache(ApiCache apiCache) async {
    final savedApiCache = await select(apiCache.key);
    if (savedApiCache == null) return -1;
    var res = await db.update(
      TABLE_NAME,
      apiCache.toMap(),
      where: "$COLUMN_API_KEY = ?",
      whereArgs: [apiCache.key],
    );
    return res;
  }

  Future<ApiCache?> select(String key) async {
    final List<Map<String, dynamic>> maps = await db
        .query(TABLE_NAME, where: "$COLUMN_API_KEY=?", whereArgs: [key]);
    /*if (maps.isNotEmpty) {
      return maps[0][COLUMN_JSON];
    }*/
    if (maps.isEmpty) {
      return null;
    }
    return ApiCache.fromMap(maps.first);
  }


  Future<T?> read<T>({
    required String apiCacheKey,
    required T Function(String json) mapper,
  }) async {
    final apiCache = await select(apiCacheKey);
    if (apiCache != null && apiCache.isValid) {

      /// if data is stored in cache and current time is
      /// in between 9:00 AM - 12:00
      /// and 5:00PM - 7:00PM,
      /// then use cached data
      ///
      // final now = TimeOfDay.now();
      // const startTime1 = TimeOfDay(hour: 9, minute: 0);
      // const endTime1 = TimeOfDay(hour: 12, minute: 0);
      // const startTime2 = TimeOfDay(hour: 17, minute: 0);
      // const endTime2 = TimeOfDay(hour: 19, minute: 0);
      //
      // if ((now.isAfter(startTime1) && now.isBefore(endTime1)) ||
      //     (now.isAfter(startTime2) && now.isBefore(endTime2))) {
      //   return mapper(apiCache.json);
      // }

      return mapper(apiCache.json);
    }
    return null;
  }

  Future<void> save({
    required String apiCacheKey,
    required String json,
  }) async {
    await upsert(
      ApiCache(
        key: apiCacheKey,
        json: json,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}
