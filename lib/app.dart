import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'data/repositories/fitness_repository.dart';
import 'data/repositories/mock_fitness_repository.dart';
import 'features/home/home_controller.dart';
import 'features/mood/mood_controller.dart';
import 'features/plan/schedule_controller.dart';
import 'features/shell/main_shell.dart';

class EvencirApp extends StatelessWidget {
  const EvencirApp({
    super.key,
    required this.prefs,
    this.repository,
    this.clock,
  });

  final SharedPreferences prefs;

  final FitnessRepository? repository;

  final DateTime Function()? clock;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController(prefs)),
        Provider<FitnessRepository>(
          create: (_) =>
              repository ??
              MockFitnessRepository(
                clock: clock,
                latency: const Duration(milliseconds: 400),
              ),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleController(
            context.read<FitnessRepository>(),
            clock: clock,
          )..load(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              HomeController(context.read<FitnessRepository>(), clock: clock)
                ..load(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              MoodController(context.read<FitnessRepository>(), clock: clock),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(439, 956),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => Consumer<ThemeController>(
          builder: (context, theme, _) => MaterialApp(
            title: 'Evencir Fitness',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: theme.mode,
            home: const MainShell(),
          ),
        ),
      ),
    );
  }
}
