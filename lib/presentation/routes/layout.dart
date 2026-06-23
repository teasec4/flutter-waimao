import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/settings_provider.dart';
import 'package:paste_tool/presentation/widgets/responsive_wrapper.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  static const _destinations = [
    (icon: Icons.content_copy, label: 'Фразы'),
    (icon: Icons.checklist, label: 'Заметки'),
  ];

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 12,
        elevation: 1,
        shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.3),
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Paste Tool',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              settings.alwaysOnTop ? Icons.push_pin : Icons.push_pin_outlined,
              size: 18,
            ),
            tooltip: settings.alwaysOnTop
                ? 'Не поверх окон'
                : 'Поверх всех окон',
            onPressed: () => settings.toggleAlwaysOnTop(),
          ),
          IconButton(
            icon: Icon(
              settings.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              size: 18,
            ),
            tooltip: settings.isDarkMode ? 'Светлая тема' : 'Тёмная тема',
            onPressed: () => settings.toggleTheme(),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ResponsiveContentWrapper(child: navigationShell),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
          settings.saveLastTab(index);
        },
        height: 56,
        destinations: MainShell._destinations
            .map(
              (d) => NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.icon),
                label: d.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
