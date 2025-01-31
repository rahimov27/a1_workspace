import 'package:a1_workspace/features/login/presentation/widgets/app_button_w_idget.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_pages/about_us_page.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_pages/documentation_page.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 24),
                const ProfileCardWidget(),
                const SizedBox(height: 20),
                const ProfileUnitCardWidget(
                  text: "Настройки",
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DocumentationPage()));
                  },
                  child: const ProfileUnitCardWidget(
                    text: "Документация",
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUsPage()));
                  },
                  child: const ProfileUnitCardWidget(
                    text: "Новости",
                  ),
                ),
                const SizedBox(height: 16),
                const ProfileUnitCardWidget(
                  text: "Тема",
                ),
                const SizedBox(height: 5),
                const ProfileUnitCardWidget(
                  text: "О нас",
                ),
                const SizedBox(height: 30),
                const AppButtonWidget(
                  text: "Выйти",
                  borderRadius: 8,
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
