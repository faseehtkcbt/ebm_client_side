import 'package:client_side/models/category.dart';

import '../../../models/api_response.dart';
import '../../../models/brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';


class BrandProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addBrandFormKey = GlobalKey<FormState>();
  TextEditingController brandNameCtrl = TextEditingController();
  Category? selectedCategory;
  Brand? brandForUpdate;




  BrandProvider(this._dataProvider);



  addBrand() async {
    try {

      Map<String, dynamic> brand = {
        'name': brandNameCtrl.text,
        'categoryId': selectedCategory?.sId
      };
      final response =
      await service.addItem(endpointUrl: 'brands', itemData: brand);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllBrands();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add brand : ${apiResponse.message}');
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

  updateBrand() async {
    try {

      if(brandForUpdate != null) {
        Map<String, dynamic> brand = {
          'name': brandNameCtrl.text,
          'categoryId': selectedCategory?.sId
        };
        final response =
        await service.updateItem(endpointUrl: 'brands',
            itemData: brand,
            itemId: brandForUpdate?.sId ?? '');
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
            _dataProvider.getAllBrands();
          } else {
            SnackBarHelper.showErrorSnackBar(
                'Failed to update brand : ${apiResponse.message}');
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Error ${response.body?['message'] ?? response.statusText}');
        }
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An Error Occured:$e');
      rethrow;
    }
  }

  void submitBrand(){
    if(brandForUpdate != null){
      updateBrand();
    }
    else{
      addBrand();
    }
  }

  deleteBrand( Brand brand) async{
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'brands', itemId: brand.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Brand Deleted Successfully');
          _dataProvider.getAllBrands();
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


  //? set data for update on editing
  setDataForUpdateBrand(Brand? brand) {
    if (brand != null) {
      brandForUpdate = brand;
      brandNameCtrl.text = brand.name ?? '';
      selectedCategory = _dataProvider.categories.firstWhereOrNull((element) => element.sId == brand.categoryId?.id);
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update brand
  clearFields() {
    brandNameCtrl.clear();
    selectedCategory = null;
    brandForUpdate = null;
  }

  updateUI(){
    notifyListeners();
  }

}
