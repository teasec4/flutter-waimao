import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Тема ---
          Card(
            child: Consumer<SettingsProvider>(
              builder: (context, settings, _) {
                return SwitchListTile(
                  title: const Text('Тёмная тема'),
                  subtitle: const Text('Переключение между светлой и тёмной темой'),
                  secondary: Icon(
                    settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                  value: settings.isDarkMode,
                  onChanged: (_) => settings.toggleTheme(),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // --- Язык (заглушка) ---
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Язык интерфейса'),
              subtitle: const Text('Русский'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Выбор языка — скоро'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // --- О приложении (заглушка) ---
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('О приложении'),
              subtitle: const Text('Paste Tool v2.0.0+1'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Информация о приложении — скоро'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
