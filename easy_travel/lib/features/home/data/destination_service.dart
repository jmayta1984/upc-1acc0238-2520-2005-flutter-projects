import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/core/constants/api_constants.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:http/http.dart' as http;

class DestinationService {
  Future<List<Destination>> getDestinations(CategoryType category) async {
    final Uri uri = Uri.parse(ApiConstants.baseUrl).replace(
      path: ApiConstants.destinationsEndpoint,
      queryParameters: category == CategoryType.all
          ? null
          : {'type': category.label},
    );
    try {
      final response = await http.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        List maps = json['results'];
        return maps.map((json) => Destination.fromJson(json)).toList();
      }
      return Future.error('Error: ${response.statusCode}');
    } catch (e) {
      return Future.error('Error: ${e.toString()}');
    }
  }
}
