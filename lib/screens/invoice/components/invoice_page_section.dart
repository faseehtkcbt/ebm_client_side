import 'package:client_side/core/data/data_provider.dart';
import 'package:client_side/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_invoice_form.dart';
import 'invoice_pdf_genarator.dart';
import 'invoice_table.dart';

class InvoicePageSection extends StatelessWidget {
  InvoicePageSection({super.key});
  final pageView = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder:(context,dataProvider,child){
        return Container(
          height: 700,
          child: PageView.builder(
            pageSnapping: false,
            controller: pageView,
            itemCount: dataProvider.invoice.length,
            itemBuilder: (BuildContext context, int index) {
              return InvoiceTable(
                invoice: dataProvider.invoice[index],
                edit: () {
                  showInvoiceForm(context,dataProvider.invoice[index]);
                },
                delete: () {
                  context.invoiceProvider.deleteInvoice(dataProvider.invoice[index]);
                },
                printPdf: () {
                  final pdfGenerator = InvoicePdfGenerator(dataProvider.invoice[index]);
                  pdfGenerator.generateAndDownloadPdf(context);
                },
                next: () {
                  if(index != dataProvider.invoice.length-1){
                    pageView.animateToPage(index+1, duration: Duration(milliseconds: 500), curve: Curves.linear);}
                },
                back: () {
                  if(index != 0){
                    pageView.animateToPage(index-1, duration: Duration(milliseconds: 500), curve: Curves.linear);}

                },
                first: () {
                  pageView.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },last: () {
                pageView.animateToPage(dataProvider.invoice.length-1, duration: Duration(milliseconds: 500), curve: Curves.linear);
              },
              );
            },
          ),
        );
      },
    );
  }
}
