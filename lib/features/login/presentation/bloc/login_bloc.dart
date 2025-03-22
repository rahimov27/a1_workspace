import 'package:a1_workspace/shared/utils/dio_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>((event, emit) async {
      final storage = FlutterSecureStorage();
      try {
        emit(LoginUserLoading());
        final response = await dio.post(
          "http://0.0.0.0:8000/api/token/",
          data: {'username': event.userName, 'password': event.password},
        );

        // Проверка, что response.data содержит 'access'
        if (response.data != null && response.data.containsKey('access')) {
          final accessToken = response.data['access'];

          // Сохраняем токен в storage с фиксированным ключом
          await storage.write(key: "access_token", value: accessToken);
          print("Токен сохранен $accessToken");

          // Отправляем успешное состояние с токеном
          emit(LoginUserSuccess(message: accessToken));
        } else {
          emit(LoginUserError(error: "Токен не получен"));
        }
      } catch (e) {
        print("Ошибка: $e");
        emit(LoginUserError(error: e.toString()));
      }
    });
  }
}
