import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:paste_tool/presentation/widgets/responsive_wrapper.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  static const _destinations = (
    items: [
      (icon: Icons.copy, label: 'Копирование'),
      (icon: Icons.book, label: 'Словарь'),
      (icon: Icons.calculate, label: 'Объём'),
      (icon: Icons.settings, label: 'Настройки'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isCompact = width <= 800;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            labelType: isCompact
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            destinations: MainShell._destinations.items
                .map(
                  (d) => NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.icon),
                    label: Text(d.label),
                  ),
                )
                .toList(),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: ResponsiveContentWrapper(child: navigationShell),
          ),
        ],
      ),
    );
  }
}
