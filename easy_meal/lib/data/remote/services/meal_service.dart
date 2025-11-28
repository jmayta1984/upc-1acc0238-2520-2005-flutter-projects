import 'dart:convert';
import 'dart:io';

import 'package:easy_meal/core/constants/api_constants.dart';
import 'package:easy_meal/data/remote/models/meal_dto.dart';
import 'package:http/http.dart' as http;

class MealService {
  Future<List<MealDto>> getMealsByCategory(String category) async {
    final Uri uri = Uri.parse(
      ApiConstants.mealsByCategoryEndpoint,
    ).replace(queryParameters: {'c': category});

    try {
      final response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(response.body);
        final List jsons = data['meals'];
        return jsons.map((json) => MealDto.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load meals: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }
}
