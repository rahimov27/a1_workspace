import 'package:a1_workspace/features/login/presentation/pages/login_page.dart';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_pages/about_us_page.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_pages/news_page.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_pages/pdf_page.dart';
import 'package:a1_workspace/features/profile/presentation/widgets/profile_card_widget.dart';
import 'package:a1_workspace/features/profile/presentation/widgets/profile_unit_card_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName;

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Профиль",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
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
                ProfileCardWidget(
                  name: userName ?? "Айбек Талгатов",
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PdfPage()));
                  },
                  child: const ProfileUnitCardWidget(
                    text: "Отчет",
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewsPage()));
                  },
                  child: const ProfileUnitCardWidget(
                    text: "Новости",
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDarkMode
                          ? AppColors.mainGrey
                          : AppColors.mainWhite),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          "Тема",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "sf-medium",
                              color: isDarkMode
                                  ? AppColors.mainWhite
                                  : AppColors.mainGrey),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                            activeTrackColor: AppColors.mainRed,
                            value: isDarkMode,
                            onChanged: (bool value) {
                              themeProvider.toggleTheme(); // Переключаем тему
                            })
                      ],
                    ),
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
                    text: "О нас",
                  ),
                ),
                const SizedBox(height: 30),
                AppButtonWidget(
                  text: "Выйти",
                  borderRadius: 8,
                  onPressed: () async {
                    await storage.delete(key: "access_token");
                    // ignore: use_build_context_synchronously
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin =
                              Offset(-1.0, 0.0); // Начальная позиция (слева)
                          const end = Offset.zero; // Конечная позиция (обычная)
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                      (route) => false,
                    );
                  },
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
