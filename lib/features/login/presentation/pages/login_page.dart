import 'package:a1_workspace/features/login/presentation/bloc/bloc/auth_bloc.dart';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_circle.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_square.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_text_field_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_welcome_text_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/forgot_password_text.dart';
import 'package:a1_workspace/main.dart';
import 'package:a1_workspace/shared/app_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> _saveUidToPrefs(String uid) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', uid);
    }

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _saveUidToPrefs(state.user.uid);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainMenu()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error: ${state.error}")));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Auth two red circle
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
                      hintText: "Пароль",
                      controller: passwordController,
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: ForgotPasswordText(),
                    ),
                    const SizedBox(height: 40),
                    if (state is AuthLoading)
                      const AppLoaderWidget()
                    else
                      AppButtonWidget(
                        text: "Войти",
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthLoginEvent(
                              login: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                      )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
