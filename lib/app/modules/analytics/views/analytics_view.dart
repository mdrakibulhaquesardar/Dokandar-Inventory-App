import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import '../controllers/analytics_controller.dart';
import '../../../data/models/analytics_data.dart';
import '../../../widgets/Custom_AppBar.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.analytics,
        true,
        false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: themeConfig.getPrimaryColor(isDarkMode),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCards(themeConfig, isDarkMode),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.chartsReports,
                style: SafeGoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 12),
              ...controller.analyticsData.map((data) => _buildChartCard(
                    data,
                    themeConfig,
                    isDarkMode,
                    context,
                  )),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSummaryCards(AppThemeConfig themeConfig, bool isDarkMode) {
    return Obx(() {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        itemCount: controller.summary.length,
        itemBuilder: (context, index) {
          final item = controller.summary[index];
          return Card(
            elevation: 0,
            color: themeConfig.getSurfaceColor(isDarkMode),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.label,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 12,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          '${item.value.toStringAsFixed(0)} ${item.unit}',
                          style: SafeGoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.changePercentage != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: item.isPositive
                                ? Colors.green.withValues(alpha: 0.2)
                                : Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${item.changePercentage! > 0 ? '+' : ''}${item.changePercentage!.toStringAsFixed(1)}%',
                            style: SafeGoogleFonts.poppins(
                              fontSize: 9,
                              color:
                                  item.isPositive ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildChartCard(
    AnalyticsData data,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    BuildContext context,
  ) {
    final l10nLocal = AppLocalizations.of(context)!;
    IconData chartIcon;
    switch (data.chartType) {
      case ChartType.line:
        chartIcon = Icons.show_chart;
        break;
      case ChartType.bar:
        chartIcon = Icons.bar_chart;
        break;
      case ChartType.pie:
        chartIcon = Icons.pie_chart;
        break;
      case ChartType.area:
        chartIcon = Icons.area_chart;
        break;
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: themeConfig.getSurfaceColor(isDarkMode),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(chartIcon,
                    size: 20, color: themeConfig.getPrimaryColor(isDarkMode)),
                const SizedBox(width: 8),
                Text(
                  data.title,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: themeConfig.getBackgroundColor(isDarkMode),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      chartIcon,
                      size: 40,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10nLocal.chartPreview,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 12,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10nLocal.dataPoints(data.dataPoints.length),
                      style: SafeGoogleFonts.poppins(
                        fontSize: 10,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
