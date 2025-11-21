import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/core/constants/api_constants.dart';
import 'package:easy_travel/core/storage/token_storage.dart';
import 'package:easy_travel/features/home/domain/comment.dart';

import 'package:http/http.dart' as http;

class CommentService {
  Future<List<Comment>> getCommentsByDestination(int id) async {
    final Uri uri = Uri.parse(
      ApiConstants.baseUrl,
    ).replace(path: '${ApiConstants.commentsEndpoint}/$id');

    try {
      final response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        List jsons = jsonDecode(response.body);
        return jsons.map((json) => Comment.fromJson(json)).toList();
      }
      return Future.error('${response.statusCode}');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> addComment(
    int destinationId,
    String comment,
    int rating,
  ) async {
    final Uri uri = Uri.parse(
      ApiConstants.baseUrl,
    ).replace(path: ApiConstants.commentsEndpoint);

    try {
      final token = await TokenStorage().read();
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'destinationId': destinationId,
          'comment': comment,
          'rating': rating,
        }),
      );
      if (response.statusCode != HttpStatus.created) {
        return Future.error('Error: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('Error: ${e.toString()}');
    }
  }
}
