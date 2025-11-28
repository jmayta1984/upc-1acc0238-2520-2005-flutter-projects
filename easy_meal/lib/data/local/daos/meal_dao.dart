import 'package:easy_meal/core/constants/database_constants.dart';
import 'package:easy_meal/core/database/app_database.dart';
import 'package:easy_meal/data/local/models/meal_entity.dart';

class MealDao {
  Future<void> insert(MealEntity entity) async {
    final db = await AppDatabase().database;
    await db.insert(DatabaseConstants.mealTableName, entity.toMap());
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase().database;
    await db.delete(
      DatabaseConstants.mealTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(String id) async {
    final db = await AppDatabase().database;
    final maps = await db.query(
      DatabaseConstants.mealTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }

  Future<List<MealEntity>> fetchAllMeals() async {
    final db = await AppDatabase().database;
    final maps = await db.query(DatabaseConstants.mealTableName);
    return maps.map((map) => MealEntity.fromMap(map)).toList();
  }

  Future<Set<String>> fetchAllMealIds() async {
    final db = await AppDatabase().database;
    final maps = await db.query(DatabaseConstants.mealTableName);
    return maps.map((map) => map['id'] as String).toSet();
  }
}
