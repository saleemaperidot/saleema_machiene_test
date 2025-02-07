import 'package:providerskel/data/models/construction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'projects.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE projects(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT,
                location TEXT,
                startDate TEXT,
                endDate TEXT,
                status TEXT)''',
        );
      },
    );
  }

  // **Insert Project**
  Future<int> insertProject(ConstructionModel project) async {
    final db = await database;
    return await db.insert('projects', project.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ConstructionModel>> getProjects() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('projects');
    return maps.map((map) => ConstructionModel.fromMap(map)).toList();
  }

  Future<int> updateProject(ConstructionModel project) async {
    final db = await database;
    return await db.update('projects', project.toMap(),
        where: 'id = ?', whereArgs: [project.id]);
  }

  Future<int> deleteProject(int id) async {
    final db = await database;
    return await db.delete('projects', where: 'id = ?', whereArgs: [id]);
  }
}
