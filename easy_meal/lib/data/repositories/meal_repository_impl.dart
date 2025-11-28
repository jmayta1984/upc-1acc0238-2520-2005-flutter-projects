import 'package:easy_meal/data/local/daos/meal_dao.dart';
import 'package:easy_meal/data/local/models/meal_entity.dart';
import 'package:easy_meal/data/remote/models/meal_dto.dart';
import 'package:easy_meal/data/remote/services/meal_service.dart';
import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealService service;
  final MealDao dao;

  const MealRepositoryImpl({required this.service, required this.dao});

  @override
  Future<List<Meal>> getMealsByCategory(String category) async {
    try {
      final Set<String> favoriteIds = await dao.fetchAllMealIds();
      final List<MealDto> dtos = await service.getMealsByCategory(category);
      return dtos
          .map(
            (dto) => dto.toDomain().copyWith(
              isFavorite: favoriteIds.contains(dto.id),
            ),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavoriteMeal(Meal meal) {
    if (meal.isFavorite) {
      return dao.delete(meal.id);
    } else {
      final entity = MealEntity.fromDomain(meal);
      return dao.insert(entity);
    }
  }
}
