import 'package:client_side/screens/customer/provider/customer_provider.dart';

import '../../../models/area.dart';
import '../../../models/category.dart';
import '../../../models/cutomer.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class CustomerSubmitForm extends StatelessWidget {
  final Customer? customer;

  const CustomerSubmitForm({super.key, this.customer});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.customerProvider.setDataForUpdateCustomer(customer);
    return SingleChildScrollView(
      child: Form(
        key: context.customerProvider.addCustomerFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              CustomTextField(
                controller: context.customerProvider.customerCodeCtrl,
                labelText: 'Customer Code',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a customer code';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: context.customerProvider.customerNameCtrl,
                labelText: 'Customer Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a customer name';
                  }
                  return null;
                },
              ),

              Gap(defaultPadding * 2),
              Row(
                children: [
                  Expanded(
                    child: Consumer<CustomerProvider>(
                      builder: (context, customerProvider, child) {
                        return CustomDropdown(
                          initialValue: customerProvider.selectedCategory,
                          items: context.dataProvider.categories,
                          hintText: customerProvider.selectedCategory?.name ?? 'Select Category',
                          displayItem: (Category? subCategory) => subCategory?.name ?? '',
                          onChanged: (newValue) {
                            customerProvider.selectedCategory = newValue;
                            customerProvider.updateUI();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a Category';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<CustomerProvider>(
                      builder: (context, customerProvider, child) {
                        return CustomDropdown(
                          initialValue: customerProvider.selectedArea,
                          items: context.dataProvider.areas,
                          hintText: customerProvider.selectedArea?.name ?? 'Select Area',
                          displayItem: (Area? area) => area?.name ?? '',
                          onChanged: (newValue) {
                            customerProvider.selectedArea = newValue;
                            customerProvider.updateUI();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a Area';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding * 2),
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
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context.customerProvider.addCustomerFormKey.currentState!.validate()) {
                        context.customerProvider.addCustomerFormKey.currentState!.save();
                        context.customerProvider.submitCustomer();
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
      ),
    );
  }
}

// How to show the category popup
void showAddCustomerForm(BuildContext context, Customer? customer) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Customer'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: CustomerSubmitForm(customer: customer),
      );
    },
  );
}
