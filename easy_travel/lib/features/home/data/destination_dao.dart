import 'package:easy_travel/core/database/app_database.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:sqflite/sqflite.dart';

typedef Maps = List<Map<String, dynamic>>;
typedef Destinations = List<Destination>;

class DestinationDao {
  Future<void> insert(Destination destination) async {
    final Database db = await AppDatabase().database;
    await db.insert('destinations', destination.toMap());
  }

  Future<void> delete(int id) async {
    final Database db = await AppDatabase().database;
    await db.delete('destinations', where: 'id = ?', whereArgs: [id]);
  }

  Future<Destinations> fetchAll() async {
    final Database db = await AppDatabase().database;
    Maps maps = await db.query('destinations');
    return maps.map((map) => Destination.fromMap(map)).toList();
  }

  Future<bool> isFavorite(int id) async {
    final Database db = await AppDatabase().database;
    Maps maps = await db.query(
      'destinations',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
