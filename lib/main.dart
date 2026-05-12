import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/core/di/app_dependencies.dart';
import 'package:paste_tool/core/theme/app_theme.dart';
import 'package:paste_tool/presentation/providers/settings_provider.dart';
import 'package:paste_tool/presentation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDependencies.init();

  final di = AppDependencies.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: di.phraseProvider),
        ChangeNotifierProvider.value(value: di.volumeProvider),
        ChangeNotifierProvider.value(value: di.dictionaryProvider),
        ChangeNotifierProvider.value(value: di.todoProvider),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const PasteToolApp(),
    ),
  );
}

class PasteToolApp extends StatelessWidget {
  const PasteToolApp({super.key});

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
