import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/core/constants/api_constants.dart';
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
}
