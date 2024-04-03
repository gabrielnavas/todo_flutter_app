import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class TodoRepositorySqlite {
  static const String _tableName = 'todo';
  static const int version = 1;

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'todo.db'),
        onCreate: (db, version) {
      return db.execute("""
          CREATE TABLE IF NOT EXISTS $_tableName (
            id TEXT PRIMARY KEY, 
            title TEXT, 
            description TEXT,
            completed INTEGER,
            created_at TEXT,
            updated_at TEXT
          );
          """);
    }, version: version);
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await database();
    await db.insert(
      _tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await database();
    return await db.query(
      _tableName,
      orderBy: "completed ASC, created_at DESC, updated_at DESC",
    );
  }

  static Future<List<Map<String, dynamic>>> getAllCompleted() async {
    final db = await database();
    return await db.query(
      _tableName,
      where: 'completed = 1',
      orderBy: "created_at DESC, updated_at DESC",
    );
  }

  static Future<void> remove(String todoId) async {
    final db = await database();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [todoId],
    );
  }
}
