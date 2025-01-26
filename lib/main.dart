import 'package:a1_workspace/features/calendar/presentation/pages/calendar_page.dart';
import 'package:a1_workspace/features/history/presentation/pages/history_page.dart';
import 'package:a1_workspace/features/home/presentation/pages/home_page.dart';
import 'package:a1_workspace/features/profile/presentation/pages/profile_page.dart';
import 'package:a1_workspace/features/service/presentation/pages/service_page.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Persistent Bottom Navigation Bar Example",
      theme: theme,
      home: const MainMenu(),
    );
  }
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
          child: Image.asset("assets/svg/home-active.png"),
        ),
        inactiveIcon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Image.asset("assets/svg/home-inactive.png"),
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
          child: Image.asset("assets/svg/calendar-active.png"),
        ),
        title: "Календарь",
        inactiveIcon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Image.asset("assets/svg/calendar-inactive.png"),
        ),
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "sf-medium",
        ),
        icon: Image.asset("assets/svg/add.png"),
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
          child: Image.asset("assets/svg/clock-inactive.png"),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Image.asset("assets/svg/clock-active.png"),
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
          child: Image.asset("assets/svg/profile-active.png"),
        ),
        inactiveIcon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Image.asset("assets/svg/profile-inactive.png"),
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
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: AppColors.navbarBackground,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
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
