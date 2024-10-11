class Product {
  String id;
  String code;
  String name;
  String description;
  BrandId brand;
  CategoryId categoryId;
  int quantity;
  double price;
  int v;

  Product({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.brand,
    required this.categoryId,
    required this.quantity,
    required this.price,
    required this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      brand: BrandId.fromJson(json['brand']),
      categoryId: CategoryId.fromJson(json['categoryId']),
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'name': name,
      'description': description,
      'brand': brand.toJson(),
      'categoryId': categoryId.toJson(),
      'quantity': quantity,
      'price': price,
      '__v': v,
    };
  }
}

class BrandId {
  String id;
  String name;

  BrandId({
    required this.id,
    required this.name,
  });

  factory BrandId.fromJson(Map<String, dynamic> json) {
    return BrandId(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class CategoryId {
  String id;
  String name;

  CategoryId({
    required this.id,
    required this.name,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) {
    return CategoryId(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
