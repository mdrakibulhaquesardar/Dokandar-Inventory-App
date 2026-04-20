import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import '../../../widgets/Custom_AppBar.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

class ComponentsShowcaseView extends StatelessWidget {
  const ComponentsShowcaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        'Components Showcase',
        true,
        false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Buttons', themeConfig, isDarkMode),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Primary'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Outlined'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Text'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _sectionTitle('Inputs', themeConfig, isDarkMode),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Text field',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle('Cards', themeConfig, isDarkMode),
          Card(
            child: ListTile(
              leading: const Icon(Icons.insert_chart_outlined),
              title: const Text('Summary Card'),
              subtitle: const Text('Use this pattern for dashboards'),
              trailing: const Text('123'),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle('Badges & Chips', themeConfig, isDarkMode),
          Wrap(
            spacing: 8,
            children: const [
              Chip(
                label: Text('Status'),
              ),
              Chip(
                label: Text('Active'),
                avatar: CircleAvatar(
                  backgroundColor: Colors.green,
                ),
              ),
              Chip(
                label: Text('New'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _sectionTitle('Empty / Error States', themeConfig, isDarkMode),
          _stateCard(
            icon: Icons.inbox_outlined,
            title: 'No data',
            subtitle: 'This is how an empty state can look.',
            themeConfig: themeConfig,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _stateCard(
            icon: Icons.wifi_off,
            title: 'No internet',
            subtitle: 'Show a friendly message when offline (UI only).',
            themeConfig: themeConfig,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _stateCard(
            icon: Icons.error_outline,
            title: 'Something went wrong',
            subtitle: 'Use this style for generic error states.',
            themeConfig: themeConfig,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: SafeGoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: themeConfig.getTextPrimaryColor(isDarkMode),
        ),
      ),
    );
  }

  Widget _stateCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: themeConfig.getPrimaryColor(isDarkMode),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 12,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
