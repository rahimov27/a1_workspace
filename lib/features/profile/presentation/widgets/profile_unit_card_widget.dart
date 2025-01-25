import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileUnitCardWidget extends StatelessWidget {
  final String text;
  const ProfileUnitCardWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.mainGrey),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "sf-medium",
                  color: AppColors.mainWhite),
            ),
            const Spacer(),
            SvgPicture.asset("assets/svg/arrow-right.svg")
          ],
        ),
      ),
    );
  }
}
