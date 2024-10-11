import '../../../models/api_response.dart';
import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../utility/snack_bar_helper.dart';

class CategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addCategoryFormKey = GlobalKey<FormState>();
  TextEditingController categoryNameCtrl = TextEditingController();
  Category? categoryForUpdate;



  CategoryProvider(this._dataProvider);
  addCategory() async {
    try {
      Map<String, dynamic> formDataMap = {
        'name': categoryNameCtrl.text,
      };
      final response =
          await service.addItem(endpointUrl: 'categories', itemData: formDataMap);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllCategory();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add Category : ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An Error Occured:$e');
      rethrow;
    }
  }

  updateCategory() async {
    try {
      Map<String, dynamic> formDataMap = {
        'name': categoryNameCtrl.text,
      };
      final response =
      await service.updateItem(endpointUrl: 'categories', itemData: formDataMap, itemId: categoryForUpdate?.sId??'');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllCategory();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to update Category : ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An Error Occured:$e');
      rethrow;
    }
  }

  void submitCategory(){
    if(categoryForUpdate != null){
      updateCategory();
    }
    else{
      addCategory();
    }
  }



  deleteCategory( Category category) async{
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'categories', itemId: category.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Category Deleted Successfully');
          _dataProvider.getAllCategory();
        }
      }
      else{
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    }
    catch(e){
      SnackBarHelper.showErrorSnackBar('An Error Occured:$e');
      rethrow;
    }
  }



  //? to create form data for sending image with body
  Future<FormData> createFormData(
      {required Map<String, dynamic> formData}) async {

    final FormData form = FormData(formData);
    return form;
  }

  //? set data for update on editing
  setDataForUpdateCategory(Category? category) {
    if (category != null) {
      clearFields();
      categoryForUpdate = category;
      categoryNameCtrl.text = category.name ?? '';
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update category
  clearFields() {
    categoryNameCtrl.clear();
    categoryForUpdate = null;
  }
}
