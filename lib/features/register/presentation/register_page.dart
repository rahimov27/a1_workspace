import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_circle.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_square.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_text_field_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_welcome_text_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/register_button_widget.dart';
import 'package:a1_workspace/shared/utils/dio_settings.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
bool isShow = false;

class _RegisterPageState extends State<RegisterPage> {
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
                const AuthWelcomeTextWidget(
                  text: "Регистрация",
                ),
                const SizedBox(height: 56),
                AuthTextFieldWidget(
                  hintText: "Почта",
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                AuthTextFieldWidget(
                  hintText: "Логин",
                  controller: usernameController,
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
                      text: "Зарегистрироваться",
                      onPressed: () async {
                        await registerUser(usernameController.text,
                            passwordController.text, emailController.text);
                      },
                    ),
                    SizedBox(height: 40),
                    RegisterButtonWidget(
                      text1: "Есть аккаунт ?",
                      text2: " Войти",
                      function: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> registerUser(
      String userName, String password, String email) async {
    try {
      final response =
          await dio.post("http://0.0.0.0:8000/api/register/", data: {
        'email': email,
        'username': userName,
        'password': password,
      });

      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
