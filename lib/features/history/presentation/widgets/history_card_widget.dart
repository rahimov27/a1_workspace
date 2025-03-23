import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case "в работе":
          return AppColors.green;
        case "ожидание":
          return const Color.fromARGB(255, 199, 230, 1);
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

    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Убираем Expanded, чтобы избежать ошибок
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    service,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "sf",
                      color:
                          isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                    ),
                  ),
                ),
                Text(
                  price,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "sf",
                    color:
                        isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: "sf-medium",
                      color: Color(0xff919191),
                    ),
                  ),
                ),
                Text(
                  getTranslatedStatus(status),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "sf-medium",
                    color: getStatusColor(getTranslatedStatus(status)),
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
