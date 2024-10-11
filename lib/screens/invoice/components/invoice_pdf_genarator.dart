import 'dart:html';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/src/widgets/framework.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

import '../../../models/invoice.dart';

class InvoicePdfGenerator {
  final Invoice invoice;

  InvoicePdfGenerator(this.invoice);

  // Function to generate the PDF
  Future<void> generateAndDownloadPdf(BuildContext context) async {
    final pdf = pw.Document();
    final customFont = await _loadFont();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Invoice No: ${invoice.invoiceId}",
                style: pw.TextStyle(font: customFont, fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text("Date: ${invoice.date.toString().split(' ')[0]}",
                style: pw.TextStyle(font: customFont)),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Customer Name: ${invoice.customerId.name}",
                    style: pw.TextStyle(font: customFont)),
                pw.Text("Salesman: ${invoice.salesman}",
                    style: pw.TextStyle(font: customFont)),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['SN', 'Item Description', 'Description', 'Qty', 'Price', 'Amount'],
              data: List<List<String>>.generate(
                invoice.products.length,
                    (index) => [
                  (index + 1).toString(),
                  invoice.products[index].productId.name,
                  invoice.products[index].productId.description,
                  invoice.products[index].quantity.toString(),
                  (invoice.products[index].price / invoice.products[index].quantity).toString(),
                  invoice.products[index].price.toString(),
                ],
              ),
              headerStyle: pw.TextStyle(font: customFont),
              cellStyle: pw.TextStyle(font: customFont),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text("Total: ${invoice.total}",
                    style: pw.TextStyle(font: customFont)),
              ],
            ),
          ],
        ),
      ),
    );

    // Convert the PDF to Uint8List
    final pdfBytes = await pdf.save();

    // Create a Blob for the browser
    final blob = Blob([pdfBytes], 'application/pdf');
    final url = Url.createObjectUrlFromBlob(blob);

    // Create a link element and trigger a download
    final anchor = AnchorElement(href: url)
      ..setAttribute('download', 'invoice_${invoice.invoiceId}.pdf')
      ..click();

    // Cleanup the object URL
    Url.revokeObjectUrl(url);
  }

  Future<pw.Font> _loadFont() async {
    final fontData = await rootBundle.load('assets/fonts/Roboto/Roboto-Regular.ttf');
    return pw.Font.ttf(fontData);
  }
}
