
class Formule {
  int? id;
  String? name;
  String? image;
  double? price;
  Null? requis;
  String? products;
  String? createdAt;
  String? updatedAt;
  var productchoise;
 dynamic productchoiseformule;
  Formule(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.requis,
      this.products,
      this.createdAt,
      this.updatedAt});

  Formule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'].toDouble();
    requis = json['requis'];
    products = json['products'];
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
    data['products'] = this.products;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}