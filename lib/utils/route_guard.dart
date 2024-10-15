import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteGuard {
  static final RouteGuard _instance = RouteGuard._internal();
  factory RouteGuard() => _instance;
  RouteGuard._internal();

  final _storage = const FlutterSecureStorage();

  Future<bool> isAuthenticated() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) return false;

      print("User token: $token");

      final response = await http.post(
        Uri.parse(
            'https://4csm2968-3002.use.devtunnels.ms/api/auth/validate-token'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'token': token}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error validating token: $e');
      return false;
    }
  }
}
