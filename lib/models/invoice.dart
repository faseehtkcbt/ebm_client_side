class Invoice {
  String id;
  int invoiceId;
  DateTime date;
  CustomerId customerId;
  String salesman;
  List<ProductEntry> products;
  double total;

  Invoice({
    required this.id,
    required this.invoiceId,
    required this.date,
    required this.customerId,
    required this.salesman,
    required this.products,
    required this.total,
  });

  // Factory method to create an Invoice from JSON
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['_id'],
      invoiceId: json['invoiceId'],
      date: DateTime.parse(json['date']),
      customerId: CustomerId.fromJson(json['customerId']),
      salesman: json['salesman'],
      products: (json['products'] as List)
          .map((productJson) => ProductEntry.fromJson(productJson))
          .toList(),
      total: json['total'],
    );
  }

  // Method to convert Invoice to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'invoiceId': invoiceId,
      'date': date.toIso8601String(),
      'customerId': customerId.toJson(),
      'salesman': salesman,
      'products': products.map((product) => product.toJson()).toList(),
      'total': total,
    };
  }
}

class CustomerId {
  String id;
  String code;
  String name;
  String area;
  String category;

  CustomerId({
    required this.id,
    required this.code,
    required this.name,
    required this.area,
    required this.category,
  });

  // Factory method to create a Customer from JSON
  factory CustomerId.fromJson(Map<String, dynamic> json) {
    return CustomerId(
      id: json['_id'],
      code: json['code'],
      name: json['name'],
      area: json['area'],
      category: json['category'],
    );
  }

  // Method to convert Customer to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'name': name,
      'area': area,
      'category': category,
    };
  }
}

class ProductEntry {
  ProductId productId;
  int quantity;
  double price;

  ProductEntry({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  // Factory method to create a ProductEntry from JSON
  factory ProductEntry.fromJson(Map<String, dynamic> json) {
    return ProductEntry(
      productId: ProductId.fromJson(json['productId']),
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  // Method to convert ProductEntry to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId.toJson(),
      'quantity': quantity,
      'price': price,
    };
  }
}

class ProductId {
  String id;
  String code;
  String name;
  String description;
  String brand;
  String categoryId;
  int quantity;
  double price;

  ProductId({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.brand,
    required this.categoryId,
    required this.quantity,
    required this.price,
  });

  // Factory method to create a Product from JSON
  factory ProductId.fromJson(Map<String, dynamic> json) {
    return ProductId(
      id: json['_id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      brand: json['brand'],
      categoryId: json['categoryId'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  // Method to convert Product to JSON
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
    };
  }
}
