import 'package:a1_workspace/features/login/presentation/pages/login_page.dart';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_pages/about_us_page.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_pages/news_page.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_pages/documentation_page.dart';
import 'package:a1_workspace/features/profile/presentation/widgets/profile_card_widget.dart';
import 'package:a1_workspace/features/profile/presentation/widgets/profile_unit_card_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName;

  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.email ?? "Пользователь";
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Получаем текущий режим (темный или светлый) из ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

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
                ProfileCardWidget(
                  name: userName ?? "Айбек Талгатов",
                ),
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
                      color: AppColors.mainGrey),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        const Text(
                          "Тема",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "sf-medium",
                              color: AppColors.mainWhite),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                            activeColor: AppColors.mainRed,
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
                    await FirebaseAuth.instance.signOut();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('uid');
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
