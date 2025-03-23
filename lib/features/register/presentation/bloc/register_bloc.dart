import 'package:a1_workspace/shared/utils/dio_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterUserLoading());
      try {
        final response = await dio.post(
          "http://0.0.0.0:8000/api/register/",
          data: {
            'email': event.email,
            'username': event.userName,
            'password': event.password,
          },
        );

        if (response.data != null && response.data is Map<String, dynamic>) {
          final message =
              response.data?.toString() ?? "Регистрация прошла успешно";
          emit(RegisterUserSuccess(message: message));
        } else {
          emit(RegisterUserError(error: "Некорректный формат данных"));
        }
      } catch (e) {
        if (kDebugMode) {
          print("Ошибка Dio: ${e.toString()}");
        }
        emit(RegisterUserError(error: "Произошла ошибка при регистрации"));
      }
    });
  }
}
