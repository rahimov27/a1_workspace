import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HistoryCardWidget extends StatelessWidget {
  final String service;
  final String name;
  final String price;
  final String status;
  const HistoryCardWidget({
    super.key,
    required this.service,
    required this.name,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color _getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case "в работе":
          return AppColors.green;
        case "ожидание":
          return AppColors.mainYellow;
        case "нет оплаты":
          return AppColors.mainRed;
        case "завершено":
          return Colors.red;
        case "отменено":
          return AppColors.greyAuth;
        default:
          return AppColors.greyAuth;
      }
    }

    String getTranslatedStatus(String status) {
      switch (status.toLowerCase()) {
        case "completed":
          return "Завершено";
        case "in_progress":
          return "В работе";
        case "pending":
          return "Ожидание";
        case "unpaid":
          return "Нет оплаты";
        case "cancelled":
          return "Отменено";
        default:
          return "Неизвестно";
      }
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), color: AppColors.mainGrey),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  service,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "sf",
                    color: AppColors.mainWhite,
                  ),
                ),
                const Spacer(),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "sf",
                    color: AppColors.mainWhite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: "sf-medium",
                    color: Color(0xff919191),
                  ),
                ),
                const Spacer(),
                Text(
                  getTranslatedStatus(status),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "sf-medium",
                    color: _getStatusColor(getTranslatedStatus(status)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
