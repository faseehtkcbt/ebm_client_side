import 'dart:convert';

// Class to represent the sales report
class SalesReport {
  final String area;
  final List<BrandReport> brands;

  SalesReport({
    required this.area,
    required this.brands,
  });

  // Factory method to create a SalesReport from JSON
  factory SalesReport.fromJson(Map<String, dynamic> json) {
    return SalesReport(
      area: json['area'],
      brands: List<BrandReport>.from(json['brands'].map((x) => BrandReport.fromJson(x))),
    );
  }

  // Method to convert a SalesReport to JSON
  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'brands': brands.map((x) => x.toJson()).toList(),
    };
  }
}

// Class to represent a Brand
class BrandReport {
  final String brand;
  final List<ProductReport> products;

  BrandReport({
    required this.brand,
    required this.products,
  });

  factory BrandReport.fromJson(Map<String, dynamic> json) {
    return BrandReport(
      brand: json['brand'],
      products: List<ProductReport>.from(
          json['products'].map((x) => ProductReport.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'products': products.map((x) => x.toJson()).toList(),
    };
  }
}

// Class to represent a Product
class ProductReport {
  final ProductDetails productDetails;
  final double totalSales;
  final int totalQuantity;

  ProductReport({
    required this.productDetails,
    required this.totalSales,
    required this.totalQuantity,
  });

  factory ProductReport.fromJson(Map<String, dynamic> json) {
    return ProductReport(
      productDetails: ProductDetails.fromJson(json['productDetails']),
      totalSales: json['totalSales'].toDouble(),
      totalQuantity: json['totalQuantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productDetails': productDetails.toJson(),
      'totalSales': totalSales,
      'totalQuantity': totalQuantity,
    };
  }
}

// Class to represent Product Details
class ProductDetails {
  final String id;
  final String code;
  final String name;
  final String description;
  final String brand;
  final String categoryId;
  final int quantity;
  final double price;
  final BrandDetails brandDetails;

  ProductDetails({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.brand,
    required this.categoryId,
    required this.quantity,
    required this.price,
    required this.brandDetails,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['_id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      brand: json['brand'],
      categoryId: json['categoryId'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      brandDetails: BrandDetails.fromJson(json['brandDetails']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'name': name,
      'description': description,
      'brand': brand,
      'categoryId': categoryId,
      'quantity': quantity,
      'price': price,
      'brandDetails': brandDetails.toJson(),
    };
  }
}

// Class to represent Brand Details
class BrandDetails {
  final String id;
  final String name;
  final String categoryId;
  final String createdAt;
  final String updatedAt;

  BrandDetails({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrandDetails.fromJson(Map<String, dynamic> json) {
    return BrandDetails(
      id: json['_id'],
      name: json['name'],
      categoryId: json['categoryId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'categoryId': categoryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

// Function to parse JSON string into a list of SalesReport objects
List<SalesReport> salesReportFromJson(String str) =>
    List<SalesReport>.from(json.decode(str).map((x) => SalesReport.fromJson(x)));

// Function to convert a list of SalesReport objects to JSON string
String salesReportToJson(List<SalesReport> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
