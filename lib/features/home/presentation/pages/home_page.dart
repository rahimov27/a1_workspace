import 'package:a1_workspace/features/home/presentation/widgets/home_record_card.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_service_card_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_subtitle_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_title_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = [
      "assets/svg/toner.svg",
      "assets/svg/himchistka.svg",
      "assets/svg/3-x-wash.svg",
      "assets/svg/polirovka.svg",
      "assets/svg/plenka.svg",
      "assets/svg/himmoika.svg"
    ];

    final titles = [
      "Тонировка",
      "Химчистка",
      "Автомойка",
      "Полировка",
      "Защитная пленка",
      "3-х Мойка"
    ];
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const HomeTitleWidget(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 34),
          child: Column(
            children: [
              const HomeSubtitleWidget(
                title: "Записи",
                hasButton: true,
              ),
              const SizedBox(height: 14),
              const HomeRecordCard(
                name: "Азамат Бакытбеков",
                number: "+996555121212",
                service: "Тонировка",
                date: "Вс, 19 янв",
              ),
              const SizedBox(height: 8),
              const HomeRecordCard(
                name: "Азамат Бакытбеков",
                number: "+996555121212",
                service: "Тонировка",
                date: "Вс, 19 янв",
              ),
              const SizedBox(height: 30),
              const HomeSubtitleWidget(
                title: "Услуги",
                hasButton: false,
              ),
              const SizedBox(height: 14),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3.5 / 2,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return HomeServiceCardWidget(
                      icon: icons[index],
                      title: titles[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
