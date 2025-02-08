import 'package:a1_workspace/app.dart';
import 'package:a1_workspace/features/calendar/presentation/pages/calendar_page.dart';
import 'package:a1_workspace/features/history/presentation/pages/history_page.dart';
import 'package:a1_workspace/features/home/presentation/pages/home_page.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_page.dart';
import 'package:a1_workspace/features/service/presentation/pages/service_page.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/utils/dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString('uid');

  runApp(App(isLoggedIn: uid != null));
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const CalendarPage(),
      const ServicePage(),
      const HistoryPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "sf-medium",
        ),
        icon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset("assets/svg/home-active.svg"),
        ),
        inactiveIcon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset("assets/svg/home-inactive.svg"),
        ),
        title: "Дом",
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "sf-medium",
        ),
        icon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset("assets/svg/calendar-active.svg"),
        ),
        title: "Календарь",
        inactiveIcon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset("assets/svg/calendar-inactive.svg"),
        ),
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "sf-medium",
        ),
        icon: SvgPicture.asset("assets/svg/Add.svg"),
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "sf-medium",
        ),
        inactiveIcon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset("assets/svg/history-inactive.svg"),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset("assets/svg/history-active.svg"),
        ),
        title: "История",
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "sf-medium",
        ),
        icon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset("assets/svg/profile-active.svg"),
        ),
        inactiveIcon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset("assets/svg/profile-inactive.svg"),
        ),
        title: "Профиль",
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      bottomScreenMargin: 70,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: AppColors.navbarBackground,
      handleAndroidBackButtonPress: true,
      stateManagement: true,
      navBarHeight: 70,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
