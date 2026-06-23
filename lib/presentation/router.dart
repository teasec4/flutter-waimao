import 'package:go_router/go_router.dart';

import 'package:paste_tool/presentation/routes/layout.dart';
import 'package:paste_tool/presentation/routes/copy/page.dart';
import 'package:paste_tool/presentation/routes/todo/page.dart';

final router = GoRouter(
  initialLocation: '/copy',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/copy',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: CopyPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/todo',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: TodoPage()),
            ),
          ],
        ),
      ],
    ),
  ],
);
