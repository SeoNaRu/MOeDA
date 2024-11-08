import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:html' as html;

import 'package:test_project/sampleCodeIm/sample_page_im.dart';

class HotelReceiptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Receipt Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdfFile = await generatePdf();
            final bytes = await pdfFile.save();

            // 웹에서 PDF 다운로드
            final blob = html.Blob([bytes], 'application/pdf');
            final url = html.Url.createObjectUrlFromBlob(blob);
            final anchor = html.AnchorElement(href: url)
              ..setAttribute('download', 'hotel_receipt.pdf')
              ..click();
            html.Url.revokeObjectUrl(url);
          },
          child: Text('Generate Hotel Receipt PDF'),
        ),
      ),
    );
  }

  Future<pw.Document> generatePdf() async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final font = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(16.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Hotel Name', style: pw.TextStyle(font: font, fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('Receipt', style: pw.TextStyle(font: font, fontSize: 18)),
                pw.SizedBox(height: 20),
                pw.Text('Guest Information', style: pw.TextStyle(font: font, fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text('Name: John Doe'),
                pw.Text('Room Number: 101'),
                pw.Text('Check-in Date: 2023-09-20'),
                pw.Text('Check-out Date: 2023-09-22'),
                pw.SizedBox(height: 20),
                pw.Text('Itemized Charges', style: pw.TextStyle(font: font, fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Table.fromTextArray(
                  headers: ['Description', 'Amount'],
                  data: [
                    ['Room Charge (2 nights)', '\$200.00'],
                    ['Room Service', '\$50.00'],
                    ['Laundry', '\$15.00'],
                    ['Taxes & Fees', '\$25.00'],
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text('Total: \$290.00', style: pw.TextStyle(font: font, fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('Thank you for staying with us!', style: pw.TextStyle(font: font, fontSize: 14)),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }
}

void main() {
  runApp(MaterialApp(home: SamplePageIm()));
}
