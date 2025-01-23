import 'package:a1_workspace/features/login/presentation/widgets/app_button_w_idget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_circle.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_design_square.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_text_field_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/auth_welcome_text_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/forgot_password_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          // Auth two red circle
          AuthDesignCircle(top: -188, left: 228),
          AuthDesignCircle(top: -158, left: 189),

          AuthDesignSquare(bottom: -160, left: -150, rotate: 0.45),
          AuthDesignSquare(bottom: -130, left: -150, rotate: 0.15),

          // Auth welcome text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthWelcomeTextWidget(),
                SizedBox(height: 56),
                AuthTextFieldWidget(hintText: "Логин"),
                SizedBox(height: 10),
                AuthTextFieldWidget(hintText: "Пароль"),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordText(),
                ),
                SizedBox(height: 40),
                AppButtonWIdget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
