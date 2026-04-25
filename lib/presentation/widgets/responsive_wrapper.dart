import 'package:flutter/material.dart';

/// Оборачивает контент в центрированный контейнер
/// с максимальной шириной для десктопа.
class ResponsiveContentWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveContentWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const maxWidth = 960.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > maxWidth + 48) {
          return Center(
            child: SizedBox(
              width: maxWidth,
              child: child,
            ),
          );
        }
        return child;
      },
    );
  }
}
