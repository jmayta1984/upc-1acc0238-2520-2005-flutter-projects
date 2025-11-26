import 'dart:convert';
import 'dart:io';

import 'package:easy_meal/core/constants/api_constants.dart';
import 'package:easy_meal/data/remote/models/category_dto.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<CategoryDto>> getAllCategories() async {
    final Uri uri = Uri.parse(ApiConstants.categoriesEndpoint);

    try {
      final response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(response.body);
        final List jsons = data['categories'];
        return jsons.map((json) => CategoryDto.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
