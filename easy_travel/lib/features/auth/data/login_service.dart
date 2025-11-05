import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/core/constants/api_constants.dart';
import 'package:easy_travel/features/auth/domain/user.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<User> login(String email, String password) async {
    final Uri uri = Uri.parse(
      ApiConstants.baseUrl,
    ).replace(path: ApiConstants.loginEndpoint);

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        return User.fromJson(json);
      }
      return Future.error('Error: ${response.statusCode}');
    } catch (e) {
      return Future.error('Error: ${e.toString()}');
    }
  }
}
