import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HomeRecordCard extends StatelessWidget {
  final String name;
  final String number;
  final String service;
  final String date;
  const HomeRecordCard({
    super.key,
    required this.name,
    required this.number,
    required this.service,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.mainGrey),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"),
              radius: 25,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.mainWhite,
                      fontFamily: "sf-medium"),
                ),
                Text(
                  number,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.mainWhite,
                      fontFamily: "sf-regular"),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  service,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.mainWhite,
                      fontFamily: "sf-medium"),
                ),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyHomeCard,
                      fontFamily: "sf-regular"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
