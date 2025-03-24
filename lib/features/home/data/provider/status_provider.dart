// import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
// import 'package:a1_workspace/shared/utils/dio_settings.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class StatusProvider extends ChangeNotifier {
//   void changeStatus(String firstName, String lastName, String status,
//       String phone, String service, String price, String date) {
//     final FlutterSecureStorage storage = FlutterSecureStorage();

//     Future<void> refreshToken() async {
//       final refreshToken = await storage.read(key: "refresh_token");

//       if (refreshToken != null) {
//         throw Exception("Refresh token is missing");
//       }

//       final response = dio.put(SwaggerAdress.adress,data: firstName,
//           options: Options(headers: {"Authorization": "Bearer $refreshToken"}));
//     }
//   }
// }
