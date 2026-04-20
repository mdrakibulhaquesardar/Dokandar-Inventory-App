import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/services/database_service.dart';
import '../../../data/models/sale.dart';

class ReportController extends GetxController {
  final RxString reportType = 'daily'.obs; // daily, weekly, monthly
  DateTimeRange? customRange;
  final RxDouble totalSales = 0.0.obs;
  final _db = Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    _calculate();
  }

  void setReportType(String type) {
    reportType.value = type;
    _calculate();
  }

  void setRange(DateTimeRange range) {
    customRange = range;
    _calculate();
  }

  Future<void> _calculate() async {
    final sales = await _db.getAllSales();
    final filtered = _filterSales(sales);
    totalSales.value =
        filtered.fold(0.0, (sum, sale) => sum + sale.totalAmount);
  }

  List<Sale> _filterSales(List<Sale> sales) {
    final now = DateTime.now();
    late DateTime start;
    late DateTime end;

    switch (reportType.value) {
      case 'weekly':
        start = now.subtract(const Duration(days: 7));
        end = now;
        break;
      case 'monthly':
        start = DateTime(now.year, now.month, 1);
        end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
        break;
      case 'custom':
        start = customRange?.start ?? now.subtract(const Duration(days: 7));
        end = customRange?.end ?? now;
        break;
      default:
        start = DateTime(now.year, now.month, now.day);
        end = start.add(const Duration(days: 1));
    }

    return sales
        .where((s) => s.saleDate.isAfter(start.subtract(const Duration(seconds: 1))) &&
            s.saleDate.isBefore(end.add(const Duration(seconds: 1))))
        .toList();
  }

  Future<Uint8List> generatePdf() async {
    final sales = await _db.getAllSales();
    final filtered = _filterSales(sales);
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Sales Report (${reportType.value.toUpperCase()})',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Total Sales: ${totalSales.value.toStringAsFixed(2)}'),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final sale = filtered[index];
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Invoice: ${sale.invoiceNumber}'),
                      pw.Text(
                          'Date: ${sale.saleDate.toLocal().toString().split(' ').first}'),
                      pw.Text(
                          'Amount: ${sale.totalAmount.toStringAsFixed(2)}'),
                      pw.Divider(),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }
}

