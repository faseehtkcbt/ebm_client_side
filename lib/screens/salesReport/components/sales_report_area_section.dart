import 'package:client_side/screens/salesReport/components/sales_report_brand_section.dart';
import 'package:flutter/material.dart';

import '../../../models/sales_report.dart';

class SalesReportAreaSection extends StatelessWidget {
  final SalesReport salesReport;

  const SalesReportAreaSection({Key? key, required this.salesReport}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Area : ${salesReport.area}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,  // Ensures the ListView doesn't take up infinite height
            physics: NeverScrollableScrollPhysics(),  // Prevents ListView inside another scrollable widget from scrolling
            itemCount: salesReport.brands.length,
            itemBuilder: (context, index) {
              return SalesReportBrandSection(brandReport: salesReport.brands[index]);
            },
          ),
        ],
      ),
    );
  }
}