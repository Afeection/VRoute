import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/vroute_bottom_nav.dart';
import 'home_page.dart';
import 'facilities_page.dart';
import 'weather_page.dart';
import 'comments_page.dart';
import 'settings_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _pages = <Widget>[
    HomePage(),
    FacilitiesPage(),
    WeatherPage(),
    CommentsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(gradient: isDark ? AppColors.darkBg : AppColors.lightBg),
            child: const SizedBox.expand(),
          ),
          IndexedStack(index: _index, children: _pages),
        ],
      ),
      bottomNavigationBar: VRouteBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
