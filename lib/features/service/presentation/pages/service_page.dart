import 'package:a1_workspace/features/service/presentation/widgets/service_text_field.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Добавление услуги",
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
              ServiceTextField(
                text: "Имя",
              ),
              SizedBox(height: 12),
              ServiceTextField(
                text: "Фамилия",
              ),
              SizedBox(height: 12),
              ServiceTextField(
                text: "Номер телефона",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
