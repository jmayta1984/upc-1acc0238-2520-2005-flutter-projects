import 'dart:async';

import 'package:easy_meal/core/enums/status.dart';
import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/domain/repositories/meal_repository.dart';
import 'package:easy_meal/presentation/blocs/meals_event.dart';
import 'package:easy_meal/presentation/blocs/meals_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final MealRepository repository;
  MealsBloc({required this.repository}) : super(const MealsState()) {
    on<GetMealsByCategory>(_onGetMealsByCategory);
    on<ToggleFavoriteMeal>(_onToggleFavoriteMeal);
  }

  FutureOr<void> _onGetMealsByCategory(
    GetMealsByCategory event,
    Emitter<MealsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<Meal> meals = await repository.getMealsByCategory(
        event.category,
      );
      emit(state.copyWith(status: Status.success, meals: meals));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  FutureOr<void> _onToggleFavoriteMeal(
    ToggleFavoriteMeal event,
    Emitter<MealsState> emit,
  ) async {
    await repository.toggleFavoriteMeal(event.meal);
    final List<Meal> meals = state.meals.map((meal) {
      if (meal.id == event.meal.id) {
        return meal.copyWith(isFavorite: !meal.isFavorite);
      }
      return meal;
    }).toList();
    emit(state.copyWith(meals: meals));
  }
}
