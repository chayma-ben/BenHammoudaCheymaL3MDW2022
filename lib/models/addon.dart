class Addon {
  int? id;
  String? name;
  double? price;
  String? createdAt;
  String? updatedAt;
  String? description;
  String? image;
 int? quantity;

  Addon(
      {this.id,
      this.name,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.description,
      this.image,
    //  this.quantity
  });

  Addon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    image = json['image'];
    //quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;
    data['image'] = this.image;
  //  data['quantity'] = this.quantity;
    return data;
  }
}
