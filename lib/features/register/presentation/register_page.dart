import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_text_field_widget.dart';
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthTextFieldWidget(
              hintText: "Username",
              controller: usernameController,
            ),
            SizedBox(height: 10),
            AuthTextFieldWidget(
              hintText: "Email",
              controller: emailController,
            ),
            SizedBox(height: 10),
            AuthTextFieldWidget(
              isPasswordField: !isShow,
              hintText: "Пароль",
              suffixIcon: GestureDetector(
                child: Icon(isShow ? Icons.visibility : Icons.visibility_off),
                onTap: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
              ),
              isSufficIcon: true,
              controller: passwordController,
            ),
            SizedBox(height: 30),
            AppButtonWidget(
              text: "Регистрация",
              onPressed: () {
                registerUser(usernameController.text, passwordController.text,
                    emailController.text);
              },
            ),
          ],
        ),
      )),
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
