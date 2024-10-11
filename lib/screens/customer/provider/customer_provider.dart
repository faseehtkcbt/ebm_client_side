import 'package:client_side/models/cutomer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/area.dart';
import '../../../models/category.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class CustomerProvider extends ChangeNotifier{
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addCustomerFormKey = GlobalKey<FormState>();

  CustomerProvider(this._dataProvider);
  TextEditingController customerNameCtrl = TextEditingController();
  TextEditingController customerCodeCtrl = TextEditingController();

  Category? selectedCategory;
  // SubCategory? selectedSubCategory;
  Area? selectedArea;
  Customer? customerForUpdate;
  List<Area> brandsByCategory = [];
  addCustomer()async{
    try{

      Map<String, dynamic> formDataMap = {
        'code': customerCodeCtrl.text,
        'name': customerNameCtrl.text,
        'category': selectedCategory?.sId ?? '',
        'area': selectedArea?.sId ?? '',
      };

      if (customerForUpdate != null) {}
      final response = await service.addItem(endpointUrl: 'customers', itemData: formDataMap);

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllCustomer();
          clearFields();
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to add customers: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusCode}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  updateCustomer()async{
    try{
      Map<String, dynamic> formDataMap = {
        'code': customerCodeCtrl.text,
        'name': customerNameCtrl.text,
        'category': selectedCategory?.sId ?? '',
        'area': selectedArea?.sId ?? '',
      };


      if (customerForUpdate != null) {}
      final response = await service.updateItem(endpointUrl: 'customers', itemData: formDataMap, itemId: customerForUpdate?.id ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllCustomer();
          clearFields();
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to update customer: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusCode}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  deleteCustomer( Customer customer) async{
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'customers', itemId: customer.id ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Customer Deleted Successfully');
          _dataProvider.getAllCustomer();
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
  void submitCustomer(){
    if(customerForUpdate != null){
      updateCustomer();
    }
    else{
      addCustomer();
    }
  }
  setDataForUpdateCustomer(Customer? customer) {
    if (customer != null) {
      clearFields();
      customerForUpdate = customer;
      customerNameCtrl.text = customer.name ?? '';
      customerCodeCtrl.text = customer.code ?? '';
      selectedCategory = _dataProvider.categories.firstWhereOrNull((element) => element.sId == customer.category?.id);
      selectedArea = _dataProvider.areas.firstWhereOrNull((element) => element.sId == customer.area?.id);


    } else {
      clearFields();
    }
  }
  clearFields() {
    customerNameCtrl.clear();
    customerCodeCtrl.clear();
    selectedCategory = null;
    selectedArea = null;
  }
  updateUI(){
    notifyListeners();
  }
}