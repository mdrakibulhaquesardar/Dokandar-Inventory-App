import 'package:dokandar_app_inventory/app/widgets/Custom_AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../controllers/invoice_generator_controller.dart';

class InvoicePreviewView extends GetView<InvoiceGeneratorController> {
  const InvoicePreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.invoice,
        true,
        false,
      ),
      body: Container(
        color: Colors.white,
        child: Obx(() {
          if (!controller.isStoreInitialized.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: themeConfig.getPrimaryColor(isDarkMode),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.generating,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                ],
              ),
            );
          }

          if (controller.pdfBytes == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No invoice generated',
                    style: SafeGoogleFonts.poppins(
                      fontSize: 16,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.generateInvoicePdf();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Generate Invoice',
                      style: SafeGoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ColoredBox(
                    color: Colors.white,
                    child: Container(
                      color: Colors.white,
                      child: Theme(
                        data: ThemeData(
                          scaffoldBackgroundColor: Colors.white,
                          canvasColor: Colors.white,
                          cardColor: Colors.white,
                        ),
                        child: ColoredBox(
                          color: Colors.white,
                          child: SfPdfViewer.memory(
                            controller.pdfBytes!,
                            controller: controller.pdfViewerController,
                            pageLayoutMode: PdfPageLayoutMode.single,
                            scrollDirection: PdfScrollDirection.vertical,
                            canShowScrollHead: false,
                            canShowScrollStatus: false,
                            enableDoubleTapZooming: true,
                            enableTextSelection: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await controller.printInvoice();
                            },
                            icon: const Icon(Icons.print,
                                color: Colors.white, size: 18),
                            label: Text(
                              'Print',
                              style: SafeGoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await controller.shareInvoice();
                            },
                            icon: const Icon(Icons.share,
                                color: Colors.white, size: 18),
                            label: Text(
                              'Share',
                              style: SafeGoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
