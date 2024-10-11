class Brand {
  String? sId;
  String? name;
  CategoryId? categoryId;
  String? createdAt;
  String? updatedAt;

  Brand(
      {this.sId,
        this.name,
        this.categoryId,
        this.createdAt,
        this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    categoryId = json['categoryId'] != null
        ? new CategoryId.fromJson(json['categoryId'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
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