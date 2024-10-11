import '../../../models/area.dart';
import '../../../models/category.dart';
import '../../category/components/add_category_form.dart';
import '../provider/area_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';

class AreaSubmitForm extends StatelessWidget {
  final Area? area;

  const AreaSubmitForm({super.key, this.area});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.areaProvider.setDataForUpdateArea(area);
    return SingleChildScrollView(
      child: Form(
        key: context.areaProvider.addAreaFormKey,
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
                controller: context.areaProvider.areaNameCtrl,
                labelText: 'Area Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a area name';
                  }
                  return null;
                },
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
                      if (context.areaProvider.addAreaFormKey.currentState!.validate()) {
                        context.areaProvider.addAreaFormKey.currentState!.save();
                        context.areaProvider.submitArea();
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
void showAddAreaForm(BuildContext context, Area? area) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Area'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: AreaSubmitForm(area: area),
      );
    },
  );
}
