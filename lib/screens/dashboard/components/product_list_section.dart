
import 'package:client_side/utility/extensions.dart';

import '../../../../core/data/data_provider.dart';
import '../../../../utility/constants.dart';
import '../../../models/product.dart';
import 'add_product_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListSection extends StatelessWidget {
  const ProductListSection({
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
            "All Products",
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
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
                      label: Text("Product Name"),
                    ),
                    DataColumn(
                      label: Text("Category"),
                    ),
                    DataColumn(
                      label: Text("Brand"),
                    ),
                    DataColumn(
                      label: Text("Price"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.products.length,
                        (index) => productDataRow(dataProvider.products[index],edit: () {
                          showAddProductForm(context, dataProvider.products[index]);
                        },
                          delete: () {
                            context.dashBoardProvider.deleteProduct(dataProvider.products[index]);
                          },),
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

DataRow productDataRow(Product productInfo,{Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(productInfo.categoryId.name ?? '')),
      DataCell(Text(productInfo.brand.name ?? '')),
      DataCell(Text('${productInfo.price}'),),
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
