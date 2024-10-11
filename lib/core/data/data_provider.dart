import 'dart:convert';


import 'package:client_side/models/invoice.dart';
import 'package:client_side/models/sales_report.dart';

import '../../models/api_response.dart';
import '../../models/area.dart';
import '../../models/brand.dart';
import '../../models/category.dart';
import '../../models/cutomer.dart';
import '../../models/product.dart';
import '../../services/http_services.dart';
// import '../../utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';

import '../../utility/snack_bar_helper.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;


  List<Area> _allAreas = [];
  List<Area> _filteredAreas = [];
  List<Area> get areas => _filteredAreas;

  // List<SubCategory> _allSubCategories = [];
  // List<SubCategory> _filteredSubCategories = [];
  //
  // List<SubCategory> get subCategories => _filteredSubCategories;
  //
  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;
  //
  // List<VariantType> _allVariantTypes = [];
  // List<VariantType> _filteredVariantTypes = [];
  // List<VariantType> get variantTypes => _filteredVariantTypes;
  //
  // List<Variant> _allVariants = [];
  // List<Variant> _filteredVariants = [];
  // List<Variant> get variants => _filteredVariants;
  //
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;

  List<Customer> _allCustomer = [];
  List<Customer> _filteredCustomer = [];
  List<Customer> get customer => _filteredCustomer;
  //
  // List<Coupon> _allCoupons = [];
  // List<Coupon> _filteredCoupons = [];
  // List<Coupon> get coupons => _filteredCoupons;
  List<Invoice> _allInvoice = [];
  List<Invoice> _filteredInvoice = [];
  List<Invoice> get invoice => _filteredInvoice;
  //
  List<SalesReport> _allSales = [];
  List<SalesReport> _filteredSales = [];
  List<SalesReport> get sales => _filteredSales;
  //
  // List<Order> _allOrders = [];
  // List<Order> _filteredOrders = [];
  // List<Order> get orders => _filteredOrders;
  //
  // List<MyNotification> _allNotifications = [];
  // List<MyNotification> _filteredNotifications = [];
  // List<MyNotification> get notifications => _filteredNotifications;
  //
  DataProvider() {
    getAllProduct();
    getAllCategory();
    getAllArea();
    getAllCustomer();
    getAllInvoice();
  //   getAllSubCategory();
    getAllBrands();
    getAllSales();
  //   getAllVariantType();
  //   getAllVariant();
  //   getAllPosters();
  //   getAllCoupons();
  //   getAllOrders();
  //   getAllNotifications();
  }
  //
  Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'categories');
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Category.fromJson(item))
                    .toList());
        _allCategories = apiResponse.data ?? [];
        _filteredCategories = List.from(_allCategories);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredCategories;
  }

  Future<List<SalesReport>> getAllSales({bool showSnack = false,String customer = "", DateTime? from,DateTime? to  }) async {
    try {
      Response response = await service.getItems(endpointUrl: 'salesreport?customer=$customer&startDate=${from ?? DateTime(2005)}&endDate=${to ?? DateTime(2050)}');
      if (response.isOk) {
        ApiResponse<List<SalesReport>> apiResponse =
        ApiResponse<List<SalesReport>>.fromJson(
            response.body,
                (json) => (json as List)
                .map((item) {
                 return SalesReport.fromJson(item);
                } )
                .toList());
        _allSales = apiResponse.data ?? [];
        _filteredSales = List.from(_allSales);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredSales;
  }
  //
  void filterCategories(String keyword){
    if(keyword.isEmpty){
      _filteredCategories = List.from(_allCategories);
    }
    else{
      final lowe = keyword.toLowerCase();
      _filteredCategories = _allCategories.where((category){
        return (category.name ?? '').toLowerCase().contains(lowe);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Invoice>> getAllInvoice({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'invoices');
      if (response.isOk) {
        ApiResponse<List<Invoice>> apiResponse =
        ApiResponse<List<Invoice>>.fromJson(
            response.body,
                (json) => (json as List)
                .map((item) => Invoice.fromJson(item))
                .toList());
        _allInvoice = apiResponse.data ?? [];
        _filteredInvoice = List.from(_allInvoice);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredInvoice;
  }
  //
  // void filterInvoice(String keyword){
  //   if(keyword.isEmpty){
  //     _filteredInvoice = List.from(_allCategories);
  //   }
  //   else{
  //     final lowe = keyword.toLowerCase();
  //     _filteredInvoice = _allInvoice.where((category){
  //       return (category. ?? '').toLowerCase().contains(lowe);
  //     }).toList();
  //   }
  //   notifyListeners();
  // }

  Future<List<Area>> getAllArea({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'areas');
      if (response.isOk) {
        ApiResponse<List<Area>> apiResponse =
        ApiResponse<List<Area>>.fromJson(
            response.body,
                (json) => (json as List)
                .map((item) => Area.fromJson(item))
                .toList());
        _allAreas = apiResponse.data ?? [];
        _filteredAreas = List.from(_allAreas);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredAreas;
  }
  //
  void filterAreas(String keyword){
    if(keyword.isEmpty){
      _filteredAreas = List.from(_allAreas);
    }
    else{
      final lowe = keyword.toLowerCase();
      _filteredAreas = _allAreas.where((area){
        return (area.name ?? '').toLowerCase().contains(lowe);
      }).toList();
    }
    notifyListeners();
  }
  //
  //
  // Future<List<SubCategory>> getAllSubCategory({bool showSnack = false}) async {
  //   try {
  //     Response response = await service.getItems(endpointUrl: 'subCategories');
  //     if (response.isOk) {
  //       ApiResponse<List<SubCategory>> apiResponse =
  //       ApiResponse<List<SubCategory>>.fromJson(
  //           response.body,
  //               (json) => (json as List)
  //               .map((item) => SubCategory.fromJson(item))
  //               .toList());
  //       _allSubCategories = apiResponse.data ?? [];
  //       _filteredSubCategories = List.from(_allSubCategories);
  //       notifyListeners();
  //       if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
  //     }
  //   } catch (e) {
  //     if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
  //     rethrow;
  //   }
  //   return _filteredSubCategories;
  // }
  //
  // void filterSubCategories(String keyword){
  //   if(keyword.isEmpty){
  //     _filteredSubCategories = List.from(_allSubCategories);
  //   }
  //   else{
  //     final lowe = keyword.toLowerCase();
  //     _filteredSubCategories = _allSubCategories.where((subCategory){
  //       return (subCategory.name ?? '').toLowerCase().contains(lowe);
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
  //
  //
  //
  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'brands');
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
        ApiResponse<List<Brand>>.fromJson(
            response.body,
                (json) => (json as List)
                .map((item) => Brand.fromJson(item))
                .toList());
        _allBrands = apiResponse.data ?? [];
        _filteredBrands = List.from(_allBrands);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredBrands;
  }
  //
  void filterBrands(String keyword){
    if(keyword.isEmpty){
      _filteredBrands = List.from(_allBrands);
    }
    else{
      final lowe = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((brand){
        return (brand.name ?? '').toLowerCase().contains(lowe);
      }).toList();
    }
    notifyListeners();
  }

  //
  // Future<List<VariantType>> getAllVariantType({bool showSnack = false}) async {
  //   try {
  //     Response response = await service.getItems(endpointUrl: 'variantTypes');
  //     if (response.isOk) {
  //       ApiResponse<List<VariantType>> apiResponse =
  //       ApiResponse<List<VariantType>>.fromJson(
  //           response.body,
  //               (json) => (json as List)
  //               .map((item) => VariantType.fromJson(item))
  //               .toList());
  //       _allVariantTypes = apiResponse.data ?? [];
  //       _filteredVariantTypes = List.from(_allVariantTypes);
  //       notifyListeners();
  //       if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
  //       return _filteredVariantTypes;
  //     }
  //   } catch (e) {
  //     if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
  //     rethrow;
  //   }
  //   return _filteredVariantTypes;
  // }
  //
  // void filterVariantTypes(String keyword){
  //   if(keyword.isEmpty){
  //     _filteredVariantTypes = List.from(_allVariantTypes);
  //   }
  //   else{
  //     final lowe = keyword.toLowerCase();
  //     _filteredVariantTypes = _allVariantTypes.where((variantType){
  //       return (variantType.name ?? '').toLowerCase().contains(lowe);
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
  //
  //
  // Future<List<Variant>> getAllVariant({bool showSnack = false}) async {
  //   try {
  //     Response response = await service.getItems(endpointUrl: 'variants');
  //     if (response.isOk) {
  //       ApiResponse<List<Variant>> apiResponse =
  //       ApiResponse<List<Variant>>.fromJson(
  //           response.body,
  //               (json) => (json as List)
  //               .map((item) => Variant.fromJson(item))
  //               .toList());
  //       _allVariants = apiResponse.data ?? [];
  //       _filteredVariants = List.from(_allVariants);
  //       notifyListeners();
  //       if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
  //       return _filteredVariants;
  //     }
  //   } catch (e) {
  //     if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
  //     rethrow;
  //   }
  //   return _filteredVariants;
  // }
  //
  // void filterVariants(String keyword){
  //   if(keyword.isEmpty){
  //     _filteredVariants = List.from(_allVariants);
  //   }
  //   else{
  //     final lowe = keyword.toLowerCase();
  //     _filteredVariants = _allVariants.where((variant){
  //       return (variant.name ?? '').toLowerCase().contains(lowe);
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
  //
  Future<List<Product>> getAllProduct({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'products');
      if (response.isOk) {
        ApiResponse<List<Product>> apiResponse =
        ApiResponse<List<Product>>.fromJson(
            response.body,
                (json) => (json as List)
                .map((item) => Product.fromJson(item))
                .toList());
        _allProducts = apiResponse.data ?? [];
        _filteredProducts = List.from(_allProducts);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredProducts;
  }
  //
  void filterProducts(String keyword){
    if(keyword.isEmpty){
      _filteredProducts = List.from(_allProducts);
    }
    else{
      final lowe = keyword.toLowerCase();
      _filteredProducts = _allProducts.where((product){
       final productNameContainsKeyword = (product.name ?? '').toLowerCase().contains(lowe);
       final categoryNameContainsKeyword = (product.categoryId.name ?? '').toLowerCase().contains(lowe) ?? false;
       final brandNameContainsKeyword = (product.brand.name ?? '').toLowerCase().contains(lowe) ?? false;
       return productNameContainsKeyword || categoryNameContainsKeyword || brandNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Customer>> getAllCustomer({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'customers');
      if (response.isOk) {
        ApiResponse<List<Customer>> apiResponse =
        ApiResponse<List<Customer>>.fromJson(
            response.body,
                (json) => (json as List)
                .map((item) => Customer.fromJson(item))
                .toList());
        _allCustomer = apiResponse.data ?? [];
        _filteredCustomer = List.from(_allCustomer);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredCustomer;
  }
  //
  void filterCustomer(String keyword){
    if(keyword.isEmpty){
      _filteredCustomer = List.from(_allCustomer);
    }
    else{
      final lowe = keyword.toLowerCase();
      _filteredCustomer = _allCustomer.where((customer){
        final productNameContainsKeyword = (customer.name ?? '').toLowerCase().contains(lowe);
        final categoryNameContainsKeyword = (customer.category?.name ?? '').toLowerCase().contains(lowe) ?? false;
        final areaNameContainsKeyword = (customer.area?.name ?? '').toLowerCase().contains(lowe) ?? false;
        return productNameContainsKeyword || categoryNameContainsKeyword || areaNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }

  // Future<List<Coupon>> getAllCoupons({bool showSnack = false}) async {
  //   try {
  //     Response response = await service.getItems(endpointUrl: 'couponCodes');
  //     if (response.isOk) {
  //       ApiResponse<List<Coupon>> apiResponse =
  //       ApiResponse<List<Coupon>>.fromJson(
  //           response.body,
  //               (json) => (json as List)
  //               .map((item) => Coupon.fromJson(item))
  //               .toList());
  //       _allCoupons = apiResponse.data ?? [];
  //       _filteredCoupons = List.from(_allCoupons);
  //       notifyListeners();
  //       if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
  //     }
  //   } catch (e) {
  //     if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
  //     rethrow;
  //   }
  //   return _filteredCoupons;
  // }
  //
  // void filterCoupons(String keyword){
  //   if(keyword.isEmpty){
  //     _filteredCoupons = List.from(_allCoupons);
  //   }
  //   else{
  //     final lowe = keyword.toLowerCase();
  //     _filteredCoupons = _allCoupons.where((coupon){
  //       return (coupon.couponCode ?? '').toLowerCase().contains(lowe);
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
  //
  // Future<List<Poster>> getAllPosters({bool showSnack = false}) async {
  //   try {
  //     Response response = await service.getItems(endpointUrl: 'posters');
  //     if (response.isOk) {
  //       ApiResponse<List<Poster>> apiResponse =
  //       ApiResponse<List<Poster>>.fromJson(
  //           response.body,
  //               (json) => (json as List)
  //               .map((item) => Poster.fromJson(item))
  //               .toList());
  //       _allPosters = apiResponse.data ?? [];
  //       _filteredPosters = List.from(_allPosters);
  //       notifyListeners();
  //       if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
  //     }
  //   } catch (e) {
  //     if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
  //     rethrow;
  //   }
  //   return _filteredPosters;
  // }
  //
  // void filterPosters(String keyword){
  //   if(keyword.isEmpty){
  //     _filteredPosters = List.from(_allPosters);
  //   }
  //   else{
  //     final lowe = keyword.toLowerCase();
  //     _filteredPosters = _allPosters.where((poster){
  //       return (poster.posterName ?? '').toLowerCase().contains(lowe);
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
  //
  //
  // Future<List<MyNotification>> getAllNotifications({bool showSnack = false}) async {
  //   try {
  //     Response response = await service.getItems(endpointUrl: 'notification/all-notification');
  //     if (response.isOk) {
  //       ApiResponse<List<MyNotification>> apiResponse =
  //       ApiResponse<List<MyNotification>>.fromJson(
  //           response.body,
  //               (json) => (json as List)
  //               .map((item) => MyNotification.fromJson(item))
  //               .toList());
  //       _allNotifications = apiResponse.data ?? [];
  //       _filteredNotifications = List.from(_allNotifications);
  //       notifyListeners();
  //       if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
  //     }
  //   } catch (e) {
  //     if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
  //     rethrow;
  //   }
  //   return _filteredNotifications;
  // }
  //
  // void filterNotifications(String keyword){
  //   if(keyword.isEmpty){
  //     _filteredNotifications = List.from(_allNotifications);
  //   }
  //   else{
  //     final lowe = keyword.toLowerCase();
  //     _filteredNotifications = _allNotifications.where((notification){
  //       return (notification.title ?? '').toLowerCase().contains(lowe);
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
  //
  //
  //
  //
  // Future<List<Order>> getAllOrders({bool showSnack = false}) async {
  //   try {
  //     Response response = await service.getItems(endpointUrl: 'orders');
  //     if (response.isOk) {
  //       ApiResponse<List<Order>> apiResponse =
  //       ApiResponse<List<Order>>.fromJson(
  //           response.body,
  //               (json) => (json as List)
  //               .map((item) => Order.fromJson(item))
  //               .toList());
  //       _allOrders = apiResponse.data ?? [];
  //       _filteredOrders = List.from(_allOrders);
  //       notifyListeners();
  //       if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
  //     }
  //   } catch (e) {
  //     if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
  //     rethrow;
  //   }
  //   return _filteredOrders;
  // }
  //
  // void filterOrders(String keyword){
  //   if(keyword.isEmpty){
  //     _filteredOrders = List.from(_allOrders);
  //   }
  //   else{
  //     final lowe = keyword.toLowerCase();
  //     _filteredOrders = _allOrders.where((order){
  //       bool nameMatches = (order.userID?.name  ?? '').toLowerCase().contains(lowe);
  //       bool statusMatches = (order.orderStatus  ?? '').toLowerCase().contains(lowe);
  //       return nameMatches || statusMatches;
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
  //
  // int calculateOrdersWithStatus({String? status}){
  //   int totalOrders = 0;
  //   if(status == null){
  //     totalOrders = _allOrders.length;
  //   }
  //   else{
  //     for(Order order in _allOrders){
  //       if(order.orderStatus == status){
  //         totalOrders += 1;
  //       }
  //     }
  //   }
  //   return totalOrders;
  // }
  //
  void filterProductsByQuantity(String productQntType) {
    if (productQntType == 'All Product') {
      _filteredProducts = List.from(_allProducts);
    } else if (productQntType == 'Out of Stock') {
      _filteredProducts = _allProducts.where((product) {
        // Filter products with quantity equal to 0 (out of stock)
        return product.quantity != null && product.quantity == 0;
      }).toList();
    } else if (productQntType == 'Limited Stock') {
      _filteredProducts = _allProducts.where((product) {
        // Filter products with quantity equal to 1 (limited stock)
        return product.quantity != null && product.quantity == 1;
      }).toList();
    } else if (productQntType == 'Other Stock') {
      _filteredProducts = _allProducts.where((product) {
        // Filter products with quantity not equal to 0 or 1 (other stock)
        return product.quantity != null && product.quantity != 0 && product.quantity != 1;
      }).toList();
    } else {
      _filteredProducts = List.from(_allProducts);
    }

    notifyListeners();
  }
  //
  int calculateProductWithQuantity({int? quantity}){
    int totalProducts = 0;
    if(quantity == null){
      totalProducts = _allProducts.length;
    }
    else{
      for(Product product in _allProducts){
        if(product.quantity != null && product.quantity == quantity){
          totalProducts += 1;
        }
      }
    }
   return totalProducts;
  }
}
