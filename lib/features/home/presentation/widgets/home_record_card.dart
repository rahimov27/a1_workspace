import 'dart:math';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:intl/intl.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRecordCard extends StatelessWidget {
  final String name;
  final String number;
  final String service;
  final String date;

  HomeRecordCard({
    super.key,
    required this.name,
    required this.number,
    required this.service,
    required this.date,
  });

  // Метод для форматирования даты
  String formatDate(String date) {
    try {
      if (date.isEmpty || date == "Нет даты") {
        return 'Нет даты';
      }
      // Пробуем распарсить дату в формате ISO
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM, HH:mm', "ru_RU").format(parsedDate);
    } catch (e) {
      // Если не удалось распарсить, возвращаем дефолтную строку
      return 'Нет даты';
    }
  }

  final Random random = Random();

  // Метод для получения случайного цвета
  Color _getRandomColor() {
    return Color.fromRGBO(
      random.nextInt(128), // Максимум 127 для менее яркого цвета
      random.nextInt(128), // Максимум 127 для менее яркого цвета
      random.nextInt(128), // Максимум 127 для менее яркого цвета
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getRandomColor(),
                  radius: 25,
                  child: Text(
                    name[0],
                    style: const TextStyle(color: AppColors.mainWhite),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode
                              ? AppColors.mainWhite
                              : AppColors.mainGrey,
                          fontFamily: "sf-medium"),
                    ),
                    Text(
                      number,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode
                              ? AppColors.mainWhite
                              : const Color(0xffA5A5A5),
                          fontFamily: "sf-regular"),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        service,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode
                                ? AppColors.mainWhite
                                : AppColors.mainGrey,
                            fontFamily: "sf-medium"),
                      ),
                      Text(
                        formatDate(date),
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.greyHomeCard,
                            fontFamily: "sf-regular"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
