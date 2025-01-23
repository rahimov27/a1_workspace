import 'package:a1_workspace/features/home/presentation/widgets/home_record_card.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_subtitle_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_title_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const HomeTitleWidget(),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 34),
          child: Column(
            children: [
              HomeSubtitleWidget(),
              SizedBox(height: 14),
              HomeRecordCard(
                name: "Азамат Бакытбеков",
                number: "+996555121212",
                service: "Тонировка",
                date: "Вс, 19 янв",
              ),
              SizedBox(height: 8),
              HomeRecordCard(
                name: "Азамат Бакытбеков",
                number: "+996555121212",
                service: "Тонировка",
                date: "Вс, 19 янв",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
