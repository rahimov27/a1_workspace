import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeServiceCardWidget extends StatelessWidget {
  final String icon;
  final String title;
  const HomeServiceCardWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.mainGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "sf-medium",
                color: AppColors.mainWhite,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const Text(
                  "Добавление услуги",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "sf-regular",
                    color: AppColors.mainWhite,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.greyUslugaColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SvgPicture.asset(icon),
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
