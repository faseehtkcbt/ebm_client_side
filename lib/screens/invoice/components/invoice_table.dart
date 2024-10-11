import 'package:client_side/models/invoice.dart';
import 'package:flutter/material.dart';

import 'add_invoice_form.dart';

class InvoiceTable extends StatelessWidget {
  final Invoice invoice;
  final Function() edit;
  final Function() next;
  final Function() back;
  final Function() first;
  final Function() last;

  final Function() delete;
  final Function() printPdf;


  const InvoiceTable({super.key,required this.invoice,required this.edit,required this.delete,required this.printPdf,required this.next,required this.back, required this.first, required this.last});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // First invoice button
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.first_page),
                    onPressed: () {
                      first();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      back();
                    },
                  ),
                  // Next (forward invoice) button
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      next();
                    },
                  ),
                  // Last invoice button
                  IconButton(
                    icon: Icon(Icons.last_page),
                    onPressed: () {
                      last();
                    },
                  ),
                ],
              ),
              // Back (previous invoice) button

              Row(
                children: [
                  ElevatedButton(onPressed: () {
                   edit();
                  }, child: Text('Edit')),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(onPressed: () {
                    delete();
                  }, child: Text('Delete')),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(onPressed: () {
                    printPdf();
                  }, child: Text('Print')),
                ],
              ),

            ],
          ),
          SizedBox(height: 20),
          Text(
            "Invoice No : ${invoice.invoiceId}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10),

          // Form fields for customer information and sales date
          Text(
            "Date : ${invoice.date.toString().split(' ')[0]}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Customer Name : ${invoice.customerId.name}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "SalesMan : ${invoice.salesman}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 20),

          // Table header
          Table(
            border: TableBorder.all(
              color: Colors.white
            ),
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(1),
            },
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('SN'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Item Description'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Description'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Qty'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Price'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Amount'),
                ),
              ]),
              // Example rows for the items
              for(int i=0; i<invoice.products.length;i++)
                invoiceRow(invoice.products[i], i)
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.white
            ),
            columnWidths: {
              0: FlexColumnWidth(7.0),
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
                  child: Text('${invoice.total}'),
                ),
              ]),
            ],
          ),
          SizedBox(height: 20),

          // Total section
        ],
      ),
    );
  }
}


TableRow invoiceRow(ProductEntry product,int index){
  return  TableRow(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text((index+1).toString()),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.productId.name),
    ),Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.productId.description),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.quantity.toString()),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text((product.price/product.quantity).toString()),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.price.toString()),
    ),
  ]);
}
