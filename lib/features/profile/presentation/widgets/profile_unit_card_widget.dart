import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileUnitCardWidget extends StatelessWidget {
  final String text;
  const ProfileUnitCardWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "sf-medium",
                  color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey),
            ),
            const Spacer(),
            isDarkMode
                ? SvgPicture.asset("assets/svg/arrow-right.svg")
                : SvgPicture.asset(
                    "assets/svg/arrow-right.svg",
                    color: AppColors.mainGrey,
                  )
          ],
        ),
      ),
    );
  }
}
