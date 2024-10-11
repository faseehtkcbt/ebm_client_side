import '../../../models/category.dart';
import '../provider/brand_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/brand.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class BrandSubmitForm extends StatelessWidget {
  final Brand? brand;

  const BrandSubmitForm({super.key, this.brand});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.brandProvider.setDataForUpdateBrand(brand);
    return SingleChildScrollView(
      child: Form(
        key: context.brandProvider.addBrandFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Consumer<BrandProvider>(
                      builder: (context, brandProvider, child) {
                        return CustomDropdown(
                          initialValue: brandProvider.selectedCategory,
                          items: context.dataProvider.categories,
                          hintText: brandProvider.selectedCategory?.name ?? 'Select Category',
                          displayItem: (Category? subCategory) => subCategory?.name ?? '',
                          onChanged: (newValue) {
                            brandProvider.selectedCategory = newValue;
                            brandProvider.updateUI();
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
                    child: CustomTextField(
                      controller: context.brandProvider.brandNameCtrl,
                      labelText: 'Brand Name',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a brand name';
                        }
                        return null;
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
                  SizedBox(width: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context.brandProvider.addBrandFormKey.currentState!.validate()) {
                        context.brandProvider.addBrandFormKey.currentState!.save();
                       context.brandProvider.submitBrand();
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
void showBrandForm(BuildContext context, Brand? brand) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Brand'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: BrandSubmitForm(
          brand: brand,
        ),
      );
    },
  );
}
