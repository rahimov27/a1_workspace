import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_circle.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_square.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_text_field_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_welcome_text_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/register_button_widget.dart';
import 'package:a1_workspace/features/register/presentation/bloc/register_bloc.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Декорации на фоне
          const AuthDesignCircle(top: -188, left: 228),
          const AuthDesignCircle(top: -158, left: 189),
          const AuthDesignSquare(bottom: -160, left: -150, rotate: 0.45),
          const AuthDesignSquare(bottom: -130, left: -150, rotate: 0.15),

          // Основное содержимое
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthWelcomeTextWidget(text: "Регистрация"),
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
                BlocListener<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterUserSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Регистрация прошла успешно!")),
                      );
                      Navigator.pop(context);
                    } else if (state is RegisterUserError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          // content: Text(state.error),
                          content: Text("Произошла ошибка при регистрации!"),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      if (state is RegisterUserLoading) {
                        return const AppLoaderWidget(); // Показываем индикатор загрузки
                      }
                      return AppButtonWidget(
                        text: "Зарегистрироваться",
                        onPressed: () {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              usernameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Заполните все поля!")));
                          } else {
                            context.read<RegisterBloc>().add(
                                  RegisterUserEvent(
                                    email: emailController.text,
                                    userName: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                          if (kDebugMode) {
                            print("Email: ${emailController.text}");
                          }
                          if (kDebugMode) {
                            print("Username: ${usernameController.text}");
                          }
                          if (kDebugMode) {
                            print("Password: ${passwordController.text}");
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                RegisterButtonWidget(
                  text1: "Есть аккаунт ?",
                  text2: " Войти",
                  function: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
