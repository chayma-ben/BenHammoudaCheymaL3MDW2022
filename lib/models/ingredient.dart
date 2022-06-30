class Ingredient {
  int? id;
  String? name;
  String? image;
  Null? quantity;
  String? description;
  Null? priceSupp;
  String? createdAt;
  String? updatedAt;
  String? categoryIds;

  Ingredient(
      {this.id,
      this.name,
      this.image,
      this.quantity,
      this.description,
      this.priceSupp,
      this.createdAt,
      this.updatedAt,
      this.categoryIds});

  Ingredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    description = json['description'];
    priceSupp = json['priceSupp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryIds = json['category_ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['priceSupp'] = this.priceSupp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_ids'] = this.categoryIds;
    return data;
  }
}
