import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'package:paste_tool/core/di/app_dependencies.dart';
import 'package:paste_tool/core/theme/app_theme.dart';
import 'package:paste_tool/presentation/providers/settings_provider.dart';
import 'package:paste_tool/presentation/router.dart';

const _lastTabKey = 'last_tab_index';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  await AppDependencies.init();

  final prefs = await SharedPreferences.getInstance();
  final savedTab = prefs.getInt(_lastTabKey) ?? 0;
  final router = createRouter(
    initialLocation: savedTab == 1 ? '/todo' : '/copy',
  );

  final di = AppDependencies.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: di.phraseProvider),
        ChangeNotifierProvider.value(value: di.todoProvider),
        ChangeNotifierProvider(create: (_) => SettingsProvider(prefs: prefs)),
      ],
      child: PasteToolApp(router: router),
    ),
  );
}

class PasteToolApp extends StatelessWidget {
  final GoRouter router;

  const PasteToolApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return MaterialApp.router(
      title: 'Paste Tool',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      routerConfig: router,
    );
  }
}
