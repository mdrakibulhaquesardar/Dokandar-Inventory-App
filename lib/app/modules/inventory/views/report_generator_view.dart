import 'dart:typed_data';

import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../widgets/Custom_AppBar.dart';

class ReportGeneratorView extends GetView<ReportController> {
  const ReportGeneratorView({super.key});

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
        l10n.generateReport,
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Report Type',
              style: SafeGoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Wrap(
                spacing: 8,
                children: [
                  _chip('Daily', 'daily'),
                  _chip('Weekly', 'weekly'),
                  _chip('Monthly', 'monthly'),
                  _chip('Custom', 'custom'),
                ],
              );
            }),
            const SizedBox(height: 12),
            GetBuilder<ReportController>(
              builder: (_) {
                if (controller.reportType.value != 'custom') {
                  return const SizedBox.shrink();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.customRange == null
                          ? 'Select Date Range'
                          : '${DateFormat.yMMMd().format(controller.customRange!.start)} - ${DateFormat.yMMMd().format(controller.customRange!.end)}',
                      style: SafeGoogleFonts.poppins(
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final now = DateTime.now();
                        final picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(now.year - 2),
                          lastDate: DateTime(now.year + 2),
                          initialDateRange: controller.customRange ??
                              DateTimeRange(
                                start: now.subtract(const Duration(days: 7)),
                                end: now,
                              ),
                        );
                        if (picked != null) {
                          controller.setRange(picked);
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text('Select Date Range'),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Obx(() {
              return Card(
                elevation: 0,
                color: themeConfig.getSurfaceColor(isDarkMode),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    l10n.totalSales,
                    style: SafeGoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  trailing: Text(
                    controller.totalSales.value.toStringAsFixed(2),
                    style: SafeGoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: themeConfig.getPrimaryColor(isDarkMode),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final bytes = await controller.generatePdf();
                  if (context.mounted) {
                    _showPdf(context, bytes, themeConfig, isDarkMode);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: Text(
                  l10n.generateReport,
                  style: SafeGoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ChoiceChip _chip(String label, String value) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    return ChoiceChip(
      label: Text(label),
      selected: controller.reportType.value == value,
      onSelected: (_) => controller.setReportType(value),
      selectedColor: themeConfig.getPrimaryColor(isDarkMode).withValues(alpha: 0.1),
    );
  }

  void _showPdf(BuildContext context, Uint8List bytes,
      AppThemeConfig themeConfig, bool isDarkMode) {
    Get.dialog(
      Dialog(
        child: SizedBox(
          height: Get.height * 0.8,
          width: Get.width * 0.9,
          child: SfPdfViewer.memory(
            bytes,
            canShowScrollHead: true,
          ),
        ),
      ),
    );
  }
}



