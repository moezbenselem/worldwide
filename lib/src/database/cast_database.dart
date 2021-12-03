import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:worldwide/src/models/castaway.dart';
import 'package:worldwide/src/models/saver.dart';

class CastAwayDatabase {
  static final CastAwayDatabase instance = CastAwayDatabase._init();

  static Database? _database;

  CastAwayDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("castdb.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT NOT NULL";
    final textTypeNull = "TEXT";
    final realType = "REAL NOT NULL";
    final dateType = "DATE NOT NULL";
    final boolType = "BOOLEAN NOT NULL";

    await db.execute(
        "CREATE TABLE $tableSavers(${SaversFields.id} $idType,${SaversFields.nom} $textTypeNull,${SaversFields.tel} $textType,${SaversFields.code} $textTypeNull,${SaversFields.active} $boolType)");

    await db.execute(
        "CREATE TABLE $tableCastAway(${castAwayFields.id} $idType,${castAwayFields.nom} $textTypeNull,${castAwayFields.prenom} $textType,${castAwayFields.tel} $textType,${castAwayFields.adresse} $textTypeNull,${castAwayFields.depart} $textTypeNull,${castAwayFields.date} $textTypeNull)");
  }

  Future<int> createClient(Saver saver) async {
    final db = await instance.database;
    final id = await db.insert(tableSavers, saver.toJson());
    return id;
  }

  Future<List<Saver>> readAllSavers() async {
    final db = await instance.database;

    final result = await db.query(tableSavers);

    return result.map((json) => Saver.fromJson(json)).toList();
  }

  Future<int> updateSaverInfo(Saver saver) async {
    final db = await instance.database;
    return await db.update(tableSavers, saver.toJson(),
        where: '${SaversFields.id} = ?', whereArgs: [saver.id]);
  }

  Future<int> editCastaway(Castaway castaway) async {
    final db = await instance.database;
    return await db.update(tableCastAway, castaway.toJson(),
        where: '${castAwayFields.id} = ?', whereArgs: [castaway.id]);
  }

  Future<int> deleteSaver(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableSavers, where: '${SaversFields.id} = ?', whereArgs: [id]);
  }

  Future<int> createCastaway(Castaway castaway) async {
    final db = await instance.database;
    final id = await db.insert(tableCastAway, castaway.toJson());
    return id;
  }

  Future<int> deleteCastaway(int id) async {
    final db = await instance.database;
    return await db.delete(tableCastAway,
        where: '${castAwayFields.id} = ?', whereArgs: [id]);
  }

  Future<List<Castaway>> readAllcastAway() async {
    final db = await instance.database;

    final result = await db.query(tableCastAway);

    return result.map((json) => Castaway.fromJson(json)).toList();
  }

  Future<int> countTodayCastaways() async {
    final db = await instance.database;

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    final result = await db.rawQuery(
        "select count(${castAwayFields.id}) as n from ${tableCastAway} where date = ${date.toIso8601String()}");

    return int.parse(result[0].values.toList()[0].toString());
  }

  Future<int> countSavers() async {
    final db = await instance.database;
    final result = await db
        .rawQuery("select count(${SaversFields.id}) as n from ${tableSavers}");

    return int.parse(result[0].values.toList()[0].toString());
  }

  Future<int> countCastaways() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        "select count(${castAwayFields.id}) as n from ${tableCastAway}");

    return int.parse(result[0].values.toList()[0].toString());
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
