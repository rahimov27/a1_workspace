import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Привет, Амир!",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "sf",
                color: AppColors.mainWhite,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Сб, 18 января",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "sf-medium",
                color: AppColors.textGreyColor,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset(
            "assets/svg/Notification.svg",
          ),
        ),
      ],
    );
  }
}
