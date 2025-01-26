import 'package:a1_workspace/features/history/presentation/widgets/history_card_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "История",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: AppColors.mainWhite,
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              SizedBox(height: 24),
              HistoryCardWidget(
                service: "Полировка",
                name: "Аскат Валиханов",
                price: "5000 сом",
                status: "В работе",
              ),
              SizedBox(height: 10),
              HistoryCardWidget(
                service: "Химчистка",
                name: "Малик Исаев",
                price: "3000 сом",
                status: "Ожидание",
              ),
              SizedBox(height: 10),
              HistoryCardWidget(
                service: "Тонировка",
                name: "Андрей Семенчук",
                price: "1500 сом",
                status: "Нет оплаты",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
