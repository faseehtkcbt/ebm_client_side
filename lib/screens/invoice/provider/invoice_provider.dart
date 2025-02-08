import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:intl/intl.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/cutomer.dart';
import '../../../models/invoice.dart';
import '../../../models/product.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class InvoiceProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final TextEditingController dateController = TextEditingController();
  InvoiceProvider(this._dataProvider);
  List<Map<String,dynamic>> selectedProducts = [];

  List<NewProductEntry> _productEntries = [];
  List<NewProductEntry> get productEntries => _productEntries;

  Customer? selectedCustomer;
  double total = 0;
  String? selectedSalesMan;
  Invoice? invoiceForUpdate;
  int? invoiceUnique;
  List<Product> productByCategory = [];

  addInvoice() async {
    invoiceUnique = _generateUniqueInvoiceId();
    try {
      Map<String, dynamic> formDataMap = {
        'invoiceId': invoiceUnique,
        'date': dateController.text,
        'customerId': selectedCustomer?.id ?? '',
        'salesman': selectedSalesMan ?? '',
        'products': selectedProducts,
        'total': total
      };
      final response =
          await service.addItem(endpointUrl: 'invoices', itemData: formDataMap);

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllInvoice();
          clearFields();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add invoice: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusCode}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  updateInvoice()async{
    try{
      Map<String, dynamic> formDataMap = {
        'invoiceId': invoiceUnique,
        'date': dateController.text,
        'customerId': selectedCustomer?.id ?? '',
        'salesman': selectedSalesMan ?? '',
        'products': selectedProducts,
        'total': total
      };
      if (invoiceForUpdate != null) {}
      final response = await service.updateItem(endpointUrl: 'invoices', itemData: formDataMap, itemId: invoiceForUpdate?.id ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllInvoice();
          clearFields();
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to update invoice: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusCode}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }
  deleteInvoice( Invoice invoice) async{
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'invoices', itemId: invoice.id ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Invoice Deleted Successfully');
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
  filterProducts(Customer customer) {
    _productEntries = [];
    selectedCustomer = customer;
    productByCategory.clear();
    final newList = _dataProvider.products.where((product)=>product.categoryId.id == customer.category?.id).toList();
    productByCategory = newList;
    notifyListeners();
  }
  void submitInvoice(){
    measureValues();
    if(invoiceForUpdate != null){
      updateInvoice();
    }
    else{
      addInvoice();
    }
  }
  int _generateUniqueInvoiceId() {
    // Combining current time in milliseconds with a random number
    return DateTime.now().millisecondsSinceEpoch +
        (1000 + Random().nextInt(9000)).toInt();
  }
  setInitialProducts(List<ProductEntry> entries){

  }
  measureValues(){
    total = 0;
    selectedProducts = [];
    for(var product in _productEntries){
      int quantity = int.parse(product.quantityController.text);
      selectedProducts.add(
        {
          "productId": product.selectedProduct?.id.toString() ??"",
          "quantity" : quantity,
          "price" : (quantity * product.selectedProduct!.price)
        }
      );
      total = total + (quantity * product.selectedProduct!.price);
    }
  }
  setDataForUpdateInvoice(Invoice? invoice) {
    _productEntries = [];
    if (invoice != null) {
      clearFields();
      invoiceForUpdate = invoice;
      invoiceUnique = invoice.invoiceId;
      dateController.text =DateFormat('yyyy-MM-dd').format(invoice.date)  ?? '';
      selectedCustomer = _dataProvider.customer.firstWhereOrNull((element) => element.id == invoice.customerId.id);
      for(var item in invoice.products){
         Product? product = _dataProvider.products.firstWhereOrNull((element) => element.id == item.productId.id);
        _productEntries.add(NewProductEntry(selectedProduct: product,));
      }
      selectedSalesMan = invoice.salesman;
    } else {
      clearFields();
    }
  }
  addNewProduct(){
    _productEntries.add(NewProductEntry());
    updateUI();
  }
  updateUI(){
    notifyListeners();
  }
  clearFields() {
    invoiceForUpdate = null;
    dateController.clear();
    _productEntries = [];
    total = 0;
    invoiceUnique = null;
    selectedCustomer = null;
    selectedProducts = [];
    selectedSalesMan = null;
  }

}
class NewProductEntry {
  Product? selectedProduct;
  TextEditingController quantityController = TextEditingController();

  NewProductEntry({this.selectedProduct});
}

