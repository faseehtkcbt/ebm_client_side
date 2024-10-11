
import 'package:flutter/material.dart';

import '../../../models/sales_report.dart';

class SalesReportProductTable extends StatelessWidget {
  final List<ProductReport> productReports;

  const SalesReportProductTable({Key? key, required this.productReports}) : super(key: key);
  double grandTotal(){
    double total =0;
    for(var i in productReports){
      total = total+i.totalSales;
    }
    return total;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 20),
      child: Column(
        children: [
          Table(
            border: TableBorder.all(width: 1, color: Colors.grey), // Adds border to the table
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),

            },
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Code", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Quantity Sold", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ]),
              for(int i=0; i < productReports.length;i++)
                invoiceRow(productReports[i], i),

            ],
          ),
          Table(
            border: TableBorder.all(width: 1, color: Colors.grey),
            columnWidths: {
              0: FlexColumnWidth(4.0),
              1: FlexColumnWidth(1.0),
              2: FlexColumnWidth(1.0),
            },
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(''),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(grandTotal().toString()),
                ),
              ]),
            ],
          ),

        ],
      ),
    );
  }
}

TableRow invoiceRow(ProductReport product,int index){
  return  TableRow(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.productDetails.code),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.productDetails.name),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.totalQuantity.toString()),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text((product.totalSales/product.totalQuantity).toString()),
    ),

    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.totalSales.toString()),
    ),
  ]);
}
