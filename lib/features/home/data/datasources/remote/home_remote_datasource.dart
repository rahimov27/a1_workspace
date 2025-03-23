import 'package:a1_workspace/features/home/data/models/home_records_model.dart';
import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class HomeRemoteDatasource {
  Future<List<HomeRecordsModel>> getRecords();
  Future<void> deleteRecord(String id);
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final Dio dio;

  HomeRemoteDatasourceImpl({required this.dio});

  final FlutterSecureStorage _storage = FlutterSecureStorage();

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
  Future<List<HomeRecordsModel>> _getRecordsWithToken(String token) async {
    final response = await dio.get(
      SwaggerAdress.adress, // Пример маршрута для получения записей
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      final List records = response.data;
      return records
          .map((record) => HomeRecordsModel.fromJson(record))
          .toList();
    } else {
      throw Exception("Unexpected response: ${response.statusCode}");
    }
  }

  @override
  Future<List<HomeRecordsModel>> getRecords() async {
    try {
      final token = await _storage.read(key: "access_token");

      if (token == null) {
        throw Exception("Access token is missing.");
      }

      // Пытаемся получить записи с текущим токеном
      return await _getRecordsWithToken(token);
    } on DioException catch (e) {
      // Если токен устарел (ошибка 401), обновляем токен и повторяем запрос
      if (e.response?.statusCode == 401) {
        await refreshToken(); // Обновляем токен
        final newToken = await _storage.read(key: "access_token");
        if (newToken != null) {
          return await _getRecordsWithToken(
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

  @override
  Future<void> deleteRecord(String id) async {
    try {
      final token = await _storage.read(key: "access_token");

      if (token == null) {
        throw Exception("Access token is missing.");
      }

      final response = await dio.delete(
        "${SwaggerAdress.adress}/$id/", // Пример маршрута для удаления записи
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 204) {
        if (kDebugMode) {
          print("Record deleted successfully.");
        }
      } else {
        throw Exception("Failed to delete record: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await refreshToken(); // Обновляем токен
        final newToken = await _storage.read(key: "access_token");
        if (newToken != null) {
          // Повторяем удаление с новым токеном
          await deleteRecord(id);
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
