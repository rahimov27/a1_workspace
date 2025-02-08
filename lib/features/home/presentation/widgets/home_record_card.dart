import 'dart:math';
import 'package:intl/intl.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

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
      // Пробуем распарсить дату в формате ISO
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy, HH:mm').format(parsedDate);
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.mainGrey),
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
                  formatDate(date), // Форматированная дата
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
