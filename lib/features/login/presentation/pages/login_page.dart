import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_circle.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_square.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_text_field_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_welcome_text_widget.dart';
import 'package:a1_workspace/features/register/presentation/register_page.dart';
import 'package:a1_workspace/main.dart';
import 'package:a1_workspace/shared/utils/dio_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShow = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    String? token = await storage.read(key: "access_token");
    if (token != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainMenu()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Auth two red circles
          const AuthDesignCircle(top: -188, left: 228),
          const AuthDesignCircle(top: -158, left: 189),

          const AuthDesignSquare(bottom: -160, left: -150, rotate: 0.45),
          const AuthDesignSquare(bottom: -130, left: -150, rotate: 0.15),

          // Auth welcome text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthWelcomeTextWidget(),
                const SizedBox(height: 56),
                AuthTextFieldWidget(
                  hintText: "Логин",
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                AuthTextFieldWidget(
                  isPasswordField: !isShow,
                  hintText: "Пароль",
                  suffixIcon: GestureDetector(
                    child:
                        Icon(isShow ? Icons.visibility : Icons.visibility_off),
                    onTap: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                  ),
                  isSufficIcon: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    AppButtonWidget(
                      text: "Войти",
                      onPressed: () async {
                        await login();
                      },
                    ),
                    SizedBox(height: 20),
                    AppButtonWidget(
                      text: "Регистрация",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    String username = emailController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showError("Заполните все поля");
      return;
    }

    try {
      print("Отправка запроса на сервер...");
      final response = await dio.post(
        "http://0.0.0.0:8000/api/token/",
        data: {'username': username, 'password': password},
      );

      print("Ответ от сервера: ${response.data}");

      final accessToken = response.data['access'];
      if (accessToken == null) {
        showError("Ошибка: Токен не получен");
        return;
      }

      await storage.write(key: 'access_token', value: accessToken);
      print("Токен сохранен: $accessToken");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
      );
    } catch (e) {
      showError("Ошибка входа: $e");
      print("Ошибка: $e");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
