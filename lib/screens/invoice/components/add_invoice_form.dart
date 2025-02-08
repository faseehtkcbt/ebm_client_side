import 'package:client_side/models/invoice.dart';
import 'package:client_side/screens/invoice/provider/invoice_provider.dart';
import 'package:client_side/utility/extensions.dart';
import 'package:provider/provider.dart';

import '../../../models/cutomer.dart';
import '../../../models/product.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../../utility/constants.dart';
import 'package:intl/intl.dart';



class InvoiceForm extends StatefulWidget {
  Invoice? invoice;
  InvoiceForm({this.invoice});
  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {


  // List of product entries

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.invoiceProvider.setDataForUpdateInvoice(widget.invoice);
    return SingleChildScrollView(
      child: Consumer<InvoiceProvider>(
        builder: (context,invoice,child){
          return Form(
            key: context.invoiceProvider.formKey,
            child: Container(
              width: size.width * 0.7,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Date Field
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.3,
                        child: CustomTextField(
                          controller: invoice.dateController,
                          labelText: 'Select Date',
                          readOnly: true,
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (selectedDate != null) {
                              invoice.dateController.text =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a date';
                            }
                            return null;
                          },
                          onSave: (String) {},
                        ),
                      ),
                      Expanded(child: Consumer<InvoiceProvider>(
                        builder: (context, invoiceProvider, child) {
                          return CustomDropdown(
                            key: ValueKey(invoiceProvider.selectedCustomer?.id),
                            initialValue: invoiceProvider.selectedCustomer,
                            hintText: invoiceProvider.selectedCustomer?.name ??
                                'Select customer',
                            items: context.dataProvider.customer,
                            displayItem: (Customer customer) =>
                            customer.name ?? '',
                            onChanged: (newValue) {
                              invoiceProvider.filterProducts(newValue!);
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a customer';
                              }
                              return null;
                            },
                          );
                        },
                      ))
                    ],
                  ),
                  SizedBox(height: defaultPadding),

                  // Customer Field
                  SizedBox(height: defaultPadding),
                   Consumer<InvoiceProvider>(
                    builder: (context, invoiceProvider, child) {
                      return CustomDropdown(
                        key: ValueKey(invoiceProvider.selectedSalesMan),
                        initialValue: invoiceProvider.selectedSalesMan,
                        hintText: invoiceProvider.selectedSalesMan ??
                            'Select salesman',
                        items: ['JohnSmith','Rober Christ','Hoodey Lee'],
                        displayItem: (String salesman) =>
                        salesman ?? '',
                        onChanged: (newValue) {
                          invoiceProvider.selectedSalesMan = newValue;
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
                  // Salesman Field
                  // CustomTextField(
                  //   controller: context.invoiceProvider.salesmanController,
                  //   labelText: 'Salesman Name',
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter salesman name';
                  //     }
                  //     return null;
                  //   },
                  //   onSave: (String) {},
                  // ),
                  SizedBox(height: defaultPadding),
                  // Products Section
                  ...context.invoiceProvider.productEntries.map((productEntry) {
                    return Row(
                      children: [
                        // Dropdown for product selection
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<Product>(
                            value: productEntry.selectedProduct,
                            items: context.invoiceProvider.productByCategory
                                .map((product) => DropdownMenuItem<Product>(
                              value: product,
                              child: Text(product.name),
                            ))
                                .toList(),
                            onChanged: (value) {
                                productEntry.selectedProduct = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Select Product',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a product';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: defaultPadding),

                        // Text field for quantity
                        Expanded(
                          flex: 1,
                          child: CustomTextField(
                            controller: productEntry.quantityController,
                            labelText: 'Quantity',
                            inputType:TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter quantity';
                              }
                              return null;
                            },
                            onSave: (String) {},
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  SizedBox(height: defaultPadding),

                  // Add Products Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      context.invoiceProvider.addNewProduct();
                    },
                    child: Text(
                      'Add Products',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: defaultPadding),

                  // Submit & Cancel Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: secondaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the popup
                        },
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: defaultPadding),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          // Validate and save the form
                          if (context.invoiceProvider.formKey.currentState!.validate()) {
                            context.invoiceProvider.formKey.currentState!.save();

                            // Perform invoice creation logic here
                            // You can now access _productEntries list for the selected products and their quantities
                            context.invoiceProvider.submitInvoice();

                            //
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Show Invoice Form Popup
void showInvoiceForm(BuildContext context,Invoice? invoice) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
          child: Text('Add Invoice'.toUpperCase(),
              style: TextStyle(color: primaryColor)),
        ),
        content: InvoiceForm(invoice: invoice,),
      );
    },
  );
}
