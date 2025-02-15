import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      sendTimeout: Duration(seconds: 5),
      baseUrl: SwaggerAdress.adress),
);
