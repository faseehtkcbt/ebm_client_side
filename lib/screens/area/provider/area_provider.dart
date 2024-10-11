import '../../../models/api_response.dart';
import '../../../models/area.dart';
import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../utility/snack_bar_helper.dart';

class AreaProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addAreaFormKey = GlobalKey<FormState>();
  TextEditingController areaNameCtrl = TextEditingController();
  Area? areaForUpdate;



  AreaProvider(this._dataProvider);
  addArea() async {
    try {
      Map<String, dynamic> formDataMap = {
        'name': areaNameCtrl.text,
      };
      final response =
          await service.addItem(endpointUrl: 'areas', itemData: formDataMap);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllArea();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add Area : ${apiResponse.message}');
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

  updateArea() async {
    try {
      Map<String, dynamic> formDataMap = {
        'name': areaNameCtrl.text,
      };
      final response =
      await service.updateItem(endpointUrl: 'areas', itemData: formDataMap, itemId: areaForUpdate?.sId??'');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllArea( );
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to update Area : ${apiResponse.message}');
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

  void submitArea(){
    if(areaForUpdate != null){
      updateArea();
    }
    else{
      addArea();
    }
  }



  deleteArea( Area area) async{
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'areas', itemId: area.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Area Deleted Successfully');
          _dataProvider.getAllArea();
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
  setDataForUpdateArea(Area? area) {
    if (area != null) {
      clearFields();
      areaForUpdate = area;
      areaNameCtrl.text = area.name ?? '';
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update category
  clearFields() {
    areaNameCtrl.clear();
    areaForUpdate = null;
  }
}
