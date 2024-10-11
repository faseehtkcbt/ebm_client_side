import 'package:client_side/screens/invoice/components/invoice_header.dart';
import 'package:client_side/screens/invoice/components/invoice_page_section.dart';
import 'package:client_side/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utility/constants.dart';
import 'components/add_invoice_form.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            InvoiceHeader(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              "My Invoices",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            onPressed: () {
                              showInvoiceForm(context,null);
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add Invoices"),
                          ),
                          Gap(20),
                          IconButton(
                              onPressed: () {
                                context.dataProvider
                                    .getAllInvoice(showSnack: true);
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                      Gap(defaultPadding),
                      InvoicePageSection()
                      // CategoryListSection(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
