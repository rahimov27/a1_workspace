import 'dart:ui';

import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSuccessWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const AppSuccessWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment
                  .center, // Центрирует все элементы относительно центра
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: const Color(0xff59E66F).withOpacity(0.25),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xff59E66F).withOpacity(0.40),
                ),
                const CircleAvatar(
                    radius: 30, backgroundColor: Color(0xff59E66F)),
                Positioned(
                  top: 58,
                  left: 58,
                  child: SvgPicture.asset("assets/svg/done.svg"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Column(
              children: [
                Text(
                  "Успешно",
                  style: TextStyle(
                    fontFamily: "sf-medium",
                    color: AppColors.mainWhite,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  textAlign: TextAlign.center,
                  "Данные успешно отправлены!",
                  style: TextStyle(
                    height: 1,
                    fontFamily: "sf-medium",
                    color: Color(0xff919191),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            AppButtonWidget(
              text: "Продолжить",
              onPressed: onPressed,
              color: const Color(0xff59E66F),
            ),
          ],
        ),
      )),
    );
  }
}
