import 'package:a1_workspace/features/login/presentation/widgets/app_button_w_idget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_circle.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_square.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_text_field_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_welcome_text_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/forgot_password_text.dart';
import 'package:a1_workspace/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<void> login() async {
      try {
        await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainMenu()));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error $e")));
      }
    }

    return Scaffold(
      body: Stack(
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
                AppButtonWidget(
                  text: "Войти",
                  onPressed: () {
                    login();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
