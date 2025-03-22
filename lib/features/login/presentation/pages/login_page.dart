import 'package:a1_workspace/features/login/presentation/bloc/login_bloc.dart';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_circle.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_square.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_text_field_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_welcome_text_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/register_button_widget.dart';
import 'package:a1_workspace/features/register/presentation/register_page.dart';
import 'package:a1_workspace/main.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShow = false;
  final TextEditingController userNameController = TextEditingController();
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
                const AuthWelcomeTextWidget(
                  text: "Вход",
                ),
                const SizedBox(height: 56),
                AuthTextFieldWidget(
                  hintText: "Логин",
                  controller: userNameController,
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
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginUserSuccess) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainMenu()));
                        } else if (state is LoginUserError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginUserLoading) {
                          return const AppLoaderWidget();
                        }

                        return AppButtonWidget(
                          text: "Войти",
                          onPressed: () async {
                            context.read<LoginBloc>().add(LoginUserEvent(
                                userName: userNameController.text,
                                password: passwordController.text));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 50),
                    RegisterButtonWidget(
                      text1: "Нету аккаунта ?",
                      text2: " Регистрация",
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
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
}
