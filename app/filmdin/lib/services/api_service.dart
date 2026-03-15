import 'package:dio/dio.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // ─── AUTH ────────────────────────────────────────────

  // Register
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      });
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }

  // Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }

  // ─── CREDITS ─────────────────────────────────────────

  // Add Credit
  static Future<Map<String, dynamic>> addCredit({
    required String token,
    required String projectName,
    required String projectType,
    required String role,
    required int year,
    required String description,
  }) async {
    try {
      final response = await _dio.post(
        '/credits',
        data: {
          'projectName': projectName,
          'projectType': projectType,
          'role': role,
          'year': year,
          'description': description,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }

  // Get My Credits
  static Future<Map<String, dynamic>> getMyCredits({
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '/credits/my',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }

  // Get Credits by User ID
  static Future<Map<String, dynamic>> getUserCredits({
    required String userId,
  }) async {
    try {
      final response = await _dio.get('/credits/user/$userId');
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }

  // Delete Credit
  static Future<Map<String, dynamic>> deleteCredit({
    required String token,
    required String creditId,
  }) async {
    try {
      final response = await _dio.delete(
        '/credits/$creditId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }

  // ─── USERS ───────────────────────────────────────────

  // Get User Profile
  static Future<Map<String, dynamic>> getUserProfile({
    required String userId,
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '/users/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }

  // Search Users
  static Future<Map<String, dynamic>> searchUsers({
    required String query,
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '/users/search?q=$query',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }
}