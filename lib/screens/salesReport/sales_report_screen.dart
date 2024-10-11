import 'package:client_side/core/data/data_provider.dart';
import 'package:client_side/screens/dashboard/components/dash_board_header.dart';
import 'package:client_side/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utility/constants.dart';
import '../../utility/snack_bar_helper.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_text_field.dart';
import 'components/sales_report_area_section.dart';

class SalesReportScreen extends StatelessWidget {
  SalesReportScreen();
  String? selectedCustomer;
  final fromdateController = TextEditingController();
  final todateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  child: CustomTextField(
                    controller: fromdateController,
                    labelText: 'Select FromDate',
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        fromdateController.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    },
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please select a date';
                      // }
                      return null;
                    },
                    onSave: (String) {},
                  ),
                ),
                SizedBox(
                  width: size.width * 0.2,
                  child: CustomTextField(
                    controller: todateController,
                    labelText: 'Select ToDate',
                    readOnly: true,
                    onTap: () async {
                      if(fromdateController.text != ""){
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        todateController.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      }}
                      else{
                        SnackBarHelper.showErrorSnackBar('Please select FromDate first');
                      }
                    },
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please select a date';
                      // }
                      return null;
                    },
                    onSave: (String) {},
                  ),
                ),
                Expanded(
                  child: Consumer<DataProvider>(
                    builder: (context, dataProvider, child) {
                      return CustomDropdown(
                        key: ValueKey(selectedCustomer),
                        initialValue: selectedCustomer,
                        hintText: selectedCustomer ??
                            'Select salesman',
                        items: dataProvider.customer.map((e)=> e.name).toList(),
                        displayItem: (String? customer) =>
                        customer ?? '',
                        onChanged: (newValue) {
                          selectedCustomer = newValue;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a customer';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      if(!(fromdateController.text != "" && todateController.text == "")){
                        context.dataProvider.getAllSales(customer: selectedCustomer ?? "",from:fromdateController.text != ""?DateFormat('yyyy-MM-dd').parse(fromdateController.text):null ,to:todateController.text != ""?DateFormat('yyyy-MM-dd').parse(todateController.text):null);
                      }
                      else{
                        SnackBarHelper.showErrorSnackBar('Please select FromDate and ToDate');

                      }
                      // Validate and save the form
                    },
                    child: Text('Submit'),
                  ),
                ),

              ],
            ),
            Consumer<DataProvider>(
              builder: (context,dataProvider,child) {
                return dataProvider.sales.length > 0 ?ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataProvider.sales.length,
                  itemBuilder: (context, index) {
                    return SalesReportAreaSection(salesReport: dataProvider.sales[index]);
                  },
                ): Container( height: 300,child: Center(child: Text("No Sales Report !!!",style: TextStyle(fontSize: 19),),));
              }
            ),
          ],
        ),
      ),
    );
  }
}