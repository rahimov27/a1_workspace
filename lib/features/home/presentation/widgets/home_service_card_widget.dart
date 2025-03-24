import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeServiceCardWidget extends StatelessWidget {
  final String icon;
  final String title;
  const HomeServiceCardWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 14, bottom: 12, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "sf-medium",
                color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  "Добавление услуги",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "sf-regular",
                    color: isDarkMode
                        ? AppColors.mainWhite
                        : const Color(0xffA5A5A5),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isDarkMode
                        ? AppColors.greyUslugaColor
                        : AppColors.serviceCardWhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SvgPicture.asset(
                      icon,
                      // ignore: deprecated_member_use
                      color:
                          isDarkMode ? AppColors.mainYellow : AppColors.mainRed,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
