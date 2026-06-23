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

    return Scaffold(
      body: SafeArea(child: ResponsiveContentWrapper(child: navigationShell)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Row(
          children: [
            Expanded(
              child: NavigationBar(
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: _goBranch,
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
            ),
            IconButton(
              icon: Icon(
                settings.alwaysOnTop ? Icons.push_pin : Icons.push_pin_outlined,
                size: 20,
              ),
              tooltip: settings.alwaysOnTop
                  ? 'Не поверх окон'
                  : 'Поверх всех окон',
              onPressed: () => settings.toggleAlwaysOnTop(),
            ),
            IconButton(
              icon: Icon(
                settings.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              tooltip: settings.isDarkMode ? 'Светлая тема' : 'Тёмная тема',
              onPressed: () => settings.toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
