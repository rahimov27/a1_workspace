import 'package:a1_workspace/features/calendar/data/models/calendar_model.dart';
import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class CalendarRemoteDatasource {
  Future<List<CalendarModel>> getCalendarRecords();
}

class CalendarRemoteDatasourceImpl extends CalendarRemoteDatasource {
  final Dio dio;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  CalendarRemoteDatasourceImpl({required this.dio});

  // Метод для обновления access token
  Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: "refresh_token");

    if (refreshToken == null) {
      throw Exception("Refresh token is missing.");
    }

    final response = await dio.post(
      "${SwaggerAdress.adress}/api/token/refresh/", // Правильный путь для обновления токена
      data: {'refresh_token': refreshToken},
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.data['access_token'];
      await _storage.write(key: "access_token", value: newAccessToken);
    } else {
      throw Exception("Failed to refresh token");
    }
  }

  // Метод для выполнения запроса с использованием access token
  Future<List<CalendarModel>> _getCalendarWithToken(String token) async {
    final response = await dio.get(
      SwaggerAdress.adress, // Правильный путь для получения календарных записей
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      final List records = response.data;
      return records.map((record) => CalendarModel.fromJson(record)).toList();
    } else {
      throw Exception("Unexpected response: ${response.statusCode}");
    }
  }

  @override
  Future<List<CalendarModel>> getCalendarRecords() async {
    try {
      final token = await _storage.read(key: "access_token");

      if (token == null) {
        throw Exception("Access token is missing.");
      }

      // Пытаемся получить записи с текущим токеном
      return await _getCalendarWithToken(token);
    } on DioException catch (e) {
      // Если токен устарел (ошибка 401), обновляем токен и повторяем запрос
      if (e.response?.statusCode == 401) {
        await refreshToken(); // Обновляем токен
        final newToken = await _storage.read(key: "access_token");
        if (newToken != null) {
          return await _getCalendarWithToken(
              newToken); // Повторяем запрос с новым токеном
        } else {
          throw Exception("Failed to retrieve a new access token");
        }
      } else {
        throw Exception("Dio error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
