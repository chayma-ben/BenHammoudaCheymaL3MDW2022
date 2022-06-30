class Productcomp {
  int? id;
  String? name;
  String? image;
  double? price;
  Null? requis;
  String? ingredients;
  String? createdAt;
  String? updatedAt;

  Productcomp(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.requis,
      this.ingredients,
      this.createdAt,
      this.updatedAt});

  Productcomp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'].toDouble();
    requis = json['requis'];
    ingredients = json['ingredients'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['requis'] = this.requis;
    data['ingredients'] = this.ingredients;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}