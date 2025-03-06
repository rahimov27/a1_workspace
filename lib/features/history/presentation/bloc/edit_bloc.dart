import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:a1_workspace/shared/utils/dio_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditInitial()) {
    on<EditUserEvent>((event, emit) async {
      try {
        final Map<String, dynamic> reverseStatusTranslation = {
          "Ожидание": "pending",
          "В работе": "in_progress",
          "Завершено": "completed",
          "Отменено": "cancelled",
          "Нет оплаты": "unpaid",
        };
        final translatedStatus =
            reverseStatusTranslation[event.status] ?? "pending";
        emit(EditUserLoading());
        final storage = FlutterSecureStorage();
        final token = await storage.read(key: "access_token");

        final response = await dio.put(
          "${SwaggerAdress.adress}/${event.id}/",
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }),
          data: {
            "first_name": event.firstName,
            "last_name": event.lastName,
            "service": event.service,
            "price": double.tryParse(event.price),
            "date": event.date.toIso8601String(),
            "status": translatedStatus
          },
        );

        if (response.statusCode == 200) {
          String message = response.data['message'] ?? "Сообщение не доступно";
          emit(EditUserSuccess(message: message));
        } else {
          emit(EditUserError(error: "Ошибка ${response.statusCode}"));
        }
      } catch (e) {
        emit(EditUserError(error: "Ошибка ${e.toString()}"));
      }
    });
  }
}
