import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AppErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const AppErrorWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment:
                Alignment.center, // Центрирует все элементы относительно центра
            children: [
              CircleAvatar(
                radius: 70,
                // ignore: deprecated_member_use
                backgroundColor: AppColors.mainRed.withOpacity(0.25),
              ),
              CircleAvatar(
                radius: 50,
                // ignore: deprecated_member_use
                backgroundColor: AppColors.mainRed.withOpacity(0.40),
              ),
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.mainRed,
              ),
              Positioned(
                top: 58,
                left: 58,
                child: SvgPicture.asset("assets/svg/close.svg"),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Text(
                "Ошибка",
                style: TextStyle(
                  fontFamily: "sf-medium",
                  color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: 200,
                child: Text(
                  textAlign: TextAlign.center,
                  "Проверьте соединение с интернетом!",
                  style: TextStyle(
                    height: 1,
                    fontFamily: "sf-medium",
                    color: Color(0xff919191),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          AppButtonWidget(
            text: "Повторить",
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
