import 'package:dokandar_app_inventory/app/data/models/store.dart';
import 'package:dokandar_app_inventory/app/modules/sell/controllers/sell_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:typed_data';

import '../../../core/services/database_service.dart';

class InvoiceGeneratorController extends GetxController {
  final pdf = pw.Document();
  Uint8List? pdfBytes;
  final PdfViewerController pdfViewerController = PdfViewerController();

  final SellController _sellController = Get.find<SellController>();

  Store? store;
  final RxBool isStoreInitialized = false.obs;

  Future<void> generateInvoice() async {
    if (!isStoreInitialized.value) {
      Get.snackbar(
        'Error',
        'Store information not initialized yet. Please wait...',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    // Reset PDF document before generating new invoice
    late pw.Document pdf = pw.Document();
    pdfBytes = null;

    // Generate PDF content
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(32),
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Watermark.text(
              '${store?.name}',
              style: pw.TextStyle(
                color: PdfColors.grey200,
                fontSize: 100,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('INVOICE',
                          style: pw.TextStyle(
                              fontSize: 40, fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          'Invoice #: INV-${DateTime.now().millisecondsSinceEpoch}',
                          style: pw.TextStyle(fontSize: 16)),
                      pw.Text(
                          'Date: ${DateTime.now().toString().split(' ')[0]}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(store?.name ?? 'Store Name',
                          style: pw.TextStyle(
                              fontSize: 24, fontWeight: pw.FontWeight.bold)),
                      pw.Text('123 Business Street'),
                      pw.Text('${store?.address}'),
                      pw.Text('Phone: ${store?.phone}'),
                      pw.Text('Email: ${store?.email}'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 30),

              // Bill To Section
              // pw.Container(
              //   padding: const pw.EdgeInsets.all(16),
              //   decoration: pw.BoxDecoration(
              //     border: pw.Border.all(width: 1),
              //     borderRadius: pw.BorderRadius.circular(8),
              //   ),
              //   child: pw.Column(
              //     crossAxisAlignment: pw.CrossAxisAlignment.start,
              //     children: [
              //       pw.Text('BILL TO',
              //           style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              //       pw.SizedBox(height: 8),
              //       pw.Text('Customer Name'),
              //       pw.Text('Customer Address'),
              //       pw.Text('City, State, ZIP'),
              //       pw.Text('Phone: Customer Phone'),
              //     ],
              //   ),
              // ),
              pw.SizedBox(height: 30),

              // Items Table
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1),
                  1: const pw.FlexColumnWidth(4),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(2),
                  4: const pw.FlexColumnWidth(2),
                },
                children: [
                  // Table Header
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('No.',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Description',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Quantity',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Unit Price',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Amount',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Dynamic Item Rows
                  ..._sellController.cartItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('${index + 1}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(item.productName),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('${item.quantity.toInt()}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child:
                              pw.Text('${item.unitPrice.toStringAsFixed(2)} Tk',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                              '${item.totalPrice.toStringAsFixed(2)} Tk',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              pw.SizedBox(height: 20),

              // Totals Section
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('Subtotal: ',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            '${_sellController.total.value.toStringAsFixed(2)} Tk'),
                      ],
                    ),
                    pw.SizedBox(height: 8),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('Discount: ',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            '${_sellController.discount.value.toStringAsFixed(2)} Tk'),
                      ],
                    ),
                    pw.SizedBox(height: 8),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(8),
                      color: PdfColors.grey300,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text('Total: ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                              '${_sellController.total.value.toStringAsFixed(2)} Tk',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),

              // Payment Terms and Notes
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 1),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Payment Terms',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Please pay within 30 days'),
                    pw.SizedBox(height: 8),
                    pw.Text('Notes',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Thank you for your business!'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Convert PDF to bytes
    pdfBytes = await pdf.save();

    // Show modal bottom sheet with PDF preview
    showInvoiceBottomSheet();
  }

  void showInvoiceBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            Expanded(
              child: pdfBytes != null
                  ? Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.antiAlias,
                        child: SfPdfViewer.memory(
                          pdfBytes!,
                          controller: pdfViewerController,
                          pageLayoutMode: PdfPageLayoutMode.single,
                          scrollDirection: PdfScrollDirection.vertical,
                          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                            // Handle document loaded
                          },
                        ),
                      ),
                    )
                  : Center(child: Text('No PDF generated')),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.snackbar(
                            'Print', 'Print functionality coming soon');
                      },
                      icon: Icon(Icons.print, color: Colors.white),
                      label:
                          Text('Print', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.snackbar(
                            'Share', 'Share functionality coming soon');
                      },
                      icon: Icon(Icons.share, color: Colors.white),
                      label:
                          Text('Share', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    store = await Get.find<DatabaseService>().getStore();
    isStoreInitialized.value = store != null;
  }


  @override
  void onClose() {
    pdfViewerController.dispose();
    super.onClose();
  }
}
