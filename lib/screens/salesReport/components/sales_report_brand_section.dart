
import 'package:client_side/screens/salesReport/components/sales_report_product_section.dart';
import 'package:flutter/material.dart';

import '../../../models/sales_report.dart';

class SalesReportBrandSection extends StatelessWidget {
  final BrandReport brandReport;

  const SalesReportBrandSection({Key? key, required this.brandReport}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brand : ${brandReport.brand}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SalesReportProductTable(productReports: brandReport.products)

        ],
      ),
    );
  }
}