import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:paste_tool/presentation/widgets/responsive_wrapper.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  static const _destinations = (
    items: [
      (icon: Icons.work, label: 'Копирование', mobileLabel: 'Фразы'),
      (icon: Icons.list, label: 'Задачи', mobileLabel: 'Задачи'),
      (icon: Icons.book, label: 'Словарь', mobileLabel: 'Словарь'),
      (icon: Icons.car_repair, label: 'Объём', mobileLabel: 'Объём'),
      (icon: Icons.settings, label: 'Настройки', mobileLabel: 'Настр.'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final useBottomNavigation = width < 700;

    if (useBottomNavigation) {
      return Scaffold(
        body: SafeArea(
          bottom: false,
          child: ResponsiveContentWrapper(child: navigationShell),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          destinations: MainShell._destinations.items
              .map(
                (d) => NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.icon),
                  label: d.mobileLabel,
                ),
              )
              .toList(),
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goBranch,
            labelType: width <= 920
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
          Expanded(child: ResponsiveContentWrapper(child: navigationShell)),
        ],
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
