class Customer {
  String? id;
  String? code;
  String? name;
  AreaId? area;
  CategoryId? category;

  Customer({
    this.id,
    this.code,
    this.name,
    this.area,
    this.category,
  });

  // Factory method to create a Customer object from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'],
      code: json['code'],
      name: json['name'],
      area: json['area'] != null ? AreaId.fromJson(json['area']) : null,
      category: json['category'] != null ? CategoryId.fromJson(json['category']) : null
    );
  }

  // Method to convert Customer object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'name': name,
      'area': area?.toJson(),
      'category': category?.toJson(),
    };
  }
}

class AreaId {
  String? id;
  String? name;

  AreaId({this.id, this.name});

  // Factory method to create an Area object from JSON
  factory AreaId.fromJson(Map<String, dynamic> json) {
    return AreaId(
      id: json['_id'],
      name: json['name'],
    );
  }

  // Method to convert Area object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class CategoryId {
  String? id;
  String? name;

  CategoryId({this.id, this.name});

  // Factory method to create a Category object from JSON
  factory CategoryId.fromJson(Map<String, dynamic> json) {
    return CategoryId(
      id: json['_id'],
      name: json['name'],
    );
  }

  // Method to convert Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
