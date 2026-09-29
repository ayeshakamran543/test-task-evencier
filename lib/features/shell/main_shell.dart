import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/home_screen.dart';
import '../mood/mood_screen.dart';
import '../plan/training_calendar_screen.dart';
import '../profile/profile_screen.dart';
import '../widgets/bottom_nav_bar.dart';

enum _AppTab { nutrition, plan, mood, profile }

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  _AppTab _current = _AppTab.nutrition;

  void _goTo(_AppTab tab) {
    if (tab == _current) return;
    setState(() => _current = tab);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pages = <Widget>[
      HomeScreen(onNavigateToPlan: () => _goTo(_AppTab.plan)),
      const TrainingCalendarScreen(),
      MoodScreen(onSubmitted: () => _goTo(_AppTab.nutrition)),
      const ProfileScreen(),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Status bar icons follow the theme.
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: IndexedStack(index: _current.index, children: pages),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _current.index,
          onDestinationSelected: (i) => _goTo(_AppTab.values[i]),
          items: const [
            BottomNavItem(
              svgAsset: 'assets/svgs/nutrition.svg',
              label: 'Nutrition',
            ),
            BottomNavItem(svgAsset: 'assets/svgs/plan.svg', label: 'Plan'),
            BottomNavItem(svgAsset: 'assets/svgs/mood.svg', label: 'Mood'),
            BottomNavItem(
              svgAsset: 'assets/svgs/profile.svg',
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
