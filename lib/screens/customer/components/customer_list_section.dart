
import 'package:client_side/utility/extensions.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/cutomer.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../models/brand.dart';
import 'add_customer_form.dart';

class CustomerListSection extends StatelessWidget {
  const CustomerListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Customers",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Customer code"),
                    ),
                    DataColumn(
                      label: Text("Customer Name"),
                    ),
                    DataColumn(
                      label: Text("Category"),
                    ),
                    DataColumn(
                      label: Text("Area"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.customer.length,
                        (index) => customerDataRow(dataProvider.customer[index], index + 1, edit: () {
                          showAddCustomerForm(context, dataProvider.customer[index]);
                    }, delete: () {
                      context.customerProvider.deleteCustomer(dataProvider.customer[index]);
                    }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow customerDataRow(Customer custInfo, int index, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [

      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(index.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(custInfo.name!),
            ),
          ],
        ),
      ),
      DataCell(Text(custInfo.code?? '')),
      DataCell(Text(custInfo.category?.name ?? '')),

      DataCell(Text(custInfo.area?.name ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}
