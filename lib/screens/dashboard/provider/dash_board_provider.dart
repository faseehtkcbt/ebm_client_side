import 'dart:io';

import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/data_provider.dart';
import '../../../../models/api_response.dart';
import '../../../../models/product.dart';
import '../../../../services/http_services.dart';
import '../../../../utility/snack_bar_helper.dart';
import '../../../models/brand.dart';
import '../../../models/category.dart';

class DashBoardProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addProductFormKey = GlobalKey<FormState>();

  //?text editing controllers in dashBoard screen
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescCtrl = TextEditingController();
  TextEditingController productQntCtrl = TextEditingController();
  TextEditingController productCodeCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  // TextEditingController productOffPriceCtrl = TextEditingController();

  //? dropdown value
  Category? selectedCategory;
  // SubCategory? selectedSubCategory;
  Brand? selectedBrand;
  // VariantType? selectedVariantType;
  // List<String> selectedVariants = [];

  Product? productForUpdate;
  // File? selectedMainImage, selectedSecondImage, selectedThirdImage, selectedFourthImage, selectedFifthImage;
  // XFile? mainImgXFile, secondImgXFile, thirdImgXFile, fourthImgXFile, fifthImgXFile;

  // List<SubCategory> subCategoriesByCategory = [];
  List<Brand> brandsByCategory = [];


  DashBoardProvider(this._dataProvider);

  addProduct()async{
    try{

      Map<String, dynamic> formDataMap = {
        'code': productCodeCtrl.text,
        'name': productNameCtrl.text,
        'description': productDescCtrl.text ?? '',
        'categoryId': selectedCategory?.sId ?? '',
        'brand': selectedBrand?.sId ?? '',
        'price': productPriceCtrl.text,
        'quantity': productQntCtrl.text,
      };
      final FormData form = await createFormDataForMultipleImage(formData: formDataMap);


      if (productForUpdate != null) {}
        final response = await service.addItem(endpointUrl: 'products', itemData: formDataMap);

        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
            _dataProvider.getAllProduct();
            clearFields();
          } else {
            SnackBarHelper.showErrorSnackBar('Failed to add products: ${apiResponse.message}');
          }
        } else {
          SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusCode}');
        }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  updateProduct()async{
    try{
      Map<String, dynamic> formDataMap = {
        'code': productCodeCtrl.text,
        'name': productNameCtrl.text,
        'description': productDescCtrl.text ?? '',
        'categoryId': selectedCategory?.sId ?? '',
        'brand': selectedBrand?.sId ?? '',
        'price': productPriceCtrl.text,
        'quantity': productQntCtrl.text,
      };
      final FormData form = await createFormDataForMultipleImage(
          formData: formDataMap);

      if (productForUpdate != null) {}
      final response = await service.updateItem(endpointUrl: 'products', itemData: formDataMap, itemId: productForUpdate?.id ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllProduct();
          clearFields();
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to add products: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusCode}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }


  void submitProduct(){
    if(productForUpdate != null){
      updateProduct();
    }
    else{
      addProduct();
    }
  }
  deleteProduct( Product product) async{
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'products', itemId: product.id ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Product Deleted Successfully');
          _dataProvider.getAllProduct();
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

  Future<FormData> createFormDataForMultipleImage({
    required Map<String, dynamic> formData,
  }) async {
    // Loop over the provided image files and add them to the form data
    // Create and return the FormData object
    final FormData form = FormData(formData);
    return form;
  }

  // filterSubcategory(Category category) {
  //   selectedSubCategory = null;
  //   selectedBrand = null;
  //   selectedCategory = category;
  //   subCategoriesByCategory.clear();
  //   final newList = _dataProvider.subCategories.where((subcategory) => subcategory.categoryId?.sId == category.sId).toList();
  //   subCategoriesByCategory = newList;
  //   notifyListeners();
  // }
  //
  //
  filterBrand(Category category){
    selectedBrand = null;
    selectedCategory = category;
    brandsByCategory.clear();
    final newList = _dataProvider.brands.where((brand) => brand.categoryId?.id == category.sId).toList();
    brandsByCategory = newList;
    notifyListeners();
  }
  //
  // filterVariant(VariantType variantType){
  //   selectedVariants = [];
  //   selectedVariantType = variantType;
  //   final newList = _dataProvider.variants.where((variant) => variant.variantTypeId?.sId == variantType.sId).toList();
  //   final List<String> variantNames = newList.map((name)=>name.name ?? '').toList();
  //    variantsByVariantType = variantNames;
  //    notifyListeners();
  // }



  setDataForUpdateProduct(Product? product) {
    if (product != null) {
      productForUpdate = product;

      productNameCtrl.text = product.name ?? '';
      productDescCtrl.text = product.description ?? '';
      productPriceCtrl.text = product.price.toString();
      productCodeCtrl.text = product.code ?? '';
      productQntCtrl.text = '${product.quantity}';

      selectedCategory = _dataProvider.categories.firstWhereOrNull((element) => element.sId == product.categoryId.id);

      final newListBrands = _dataProvider.brands
          .where((brand) => brand.categoryId?.id == product.categoryId.id)
          .toList();
      // subCategoriesByCategory = newListCategory;
      // selectedSubCategory =
      //     _dataProvider.subCategories.firstWhereOrNull((element) => element.sId == product.proSubCategoryId?.sId);

      // final newListBrand =
      //     _dataProvider.brands.where((brand) => brand.subcategoryId?.sId == product.proSubCategoryId?.sId).toList();
      brandsByCategory = newListBrands;
      selectedBrand = _dataProvider.brands.firstWhereOrNull((element) => element.sId == product.brand.id);
    } else {
      clearFields();
    }
  }

  clearFields() {
    productNameCtrl.clear();
    productDescCtrl.clear();
    productPriceCtrl.clear();
    productCodeCtrl.clear();
    productQntCtrl.clear();
    selectedCategory = null;
    selectedBrand = null;
    productForUpdate = null;
  }

  updateUI() {
    notifyListeners();
  }
}

