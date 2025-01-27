import 'package:a1_workspace/features/login/presentation/widgets/app_button_w_idget.dart';
import 'package:a1_workspace/features/profile/presentation/widgets/profile_card_widget.dart';
import 'package:a1_workspace/features/profile/presentation/widgets/profile_unit_card_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "Профиль",
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 24),
                ProfileCardWidget(),
                SizedBox(height: 20),
                ProfileUnitCardWidget(
                  text: "Настройки",
                ),
                SizedBox(height: 5),
                ProfileUnitCardWidget(
                  text: "Документация",
                ),
                SizedBox(height: 5),
                ProfileUnitCardWidget(
                  text: "Новости",
                ),
                SizedBox(height: 16),
                ProfileUnitCardWidget(
                  text: "Тема",
                ),
                SizedBox(height: 5),
                ProfileUnitCardWidget(
                  text: "О нас",
                ),
                SizedBox(height: 30),
                AppButtonWidget(
                  text: "Выйти",
                  borderRadius: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
