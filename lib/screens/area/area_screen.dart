import 'package:client_side/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import 'components/add_area_form.dart';
import 'components/area_header.dart';
import 'components/area_list_section.dart';

class AreaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            AreaHeader(),
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
                              "My Areas",
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
                              showAddAreaForm(context, null);
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add New"),
                          ),
                          Gap(20),
                          IconButton(
                              onPressed: () {
                                context.dataProvider.getAllArea(showSnack: true);
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                      Gap(defaultPadding),
                      AreaListSection(),
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
