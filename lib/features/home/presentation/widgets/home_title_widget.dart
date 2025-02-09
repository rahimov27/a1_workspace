import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('E, dd MMMM', 'ru_RU').format(DateTime.now());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Привет, Админ!",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "sf",
                color: AppColors.mainWhite,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              todayDate,
              style: const TextStyle(
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
