

import 'package:flutter/foundation.dart';

class Product {
  int? id;
 String? name;
  //String? description;
  String? image;
  double? price;
  String? variations ;
  int? tax;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? attributes;
  String? categoryIds;
  String? choiceOptions;
  int? discount;
  String? discountType;
  String? taxType;
 // int? setMenu;
  int? branchId;
 // Null? colors;
 // Null? quantityStock;
  String? addOns;
  String? ingredients;
//  Null? pricedisc;
  int quantitychoise =1 ;
  String? products;
 List<Map<String, String>>? addonchoise =  [];
//String? addonchoise = "";
  double? sizechoise;
double addonquantity =0;
 int?  addonqtys = 0;
List<Map<String, String>>? ingredientchoise = [];
double? PrixProduct ;
double? prix;
String? namesize ;
List<Map<String, String>>? variation  = [];
String? selectedproducts = "";
String? selectedingredient="";
String? type ;
String? commenntaire;
int? quantity ;
String? addonname;
double? cost;

 
  
  

  Product(
      {this.id,
      this.name,
     // this.description,
      this.image,
      this.price,
      this.variations,
      this.tax,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.attributes,
      this.categoryIds,
      this.choiceOptions,
      this.discount,
      this.discountType,
      this.taxType,
     // this.setMenu,
      this.branchId,
    //  this.colors,
    //  this.quantityStock,
      this.addOns,
      this.ingredients,
    //  this.pricedisc,
     // this.quantitychoise,
         this.products,
    //  this.addonchoise,
    //  this.sizechoise,
      this.ingredientchoise,
      this.PrixProduct,
     
     });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
   // description = json['description'];
    image = json['image'];
    price = json['price'].toDouble();
    variations = json['variations'];
    tax = json['tax'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    attributes = json['attributes'];
    categoryIds = json['category_ids'];
    choiceOptions = json['choice_options'];
    discount = json['discount'];
    discountType = json['discount_type'];
    taxType = json['tax_type'];
  //  setMenu = json['set_menu'];
    branchId = json['branch_id'];
   /// colors = json['colors'];
  //  quantityStock = json['quantity_stock'];
    addOns = json['add_ons'];
    ingredients = json['ingredients'];
   // pricedisc = json['pricedisc'];
    products = json['products'];
    quantitychoise = json['quantitychoise'];
    
   // addonchoise =  json['addonochoise'];
  //  sizechoise =  json['sizechoise'];
   ingredientchoise =  json['ingredientchoise'];
    PrixProduct =  json['PrixProduct'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
   // data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['variations'] = this.namesize;
    data['tax'] = this.tax;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['attributes'] = this.attributes;
    data['category_ids'] = this.categoryIds;
    data['choice_options'] = this.choiceOptions;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['tax_type'] = this.taxType;
  //  data['set_menu'] = this.setMenu;
    data['branch_id'] = this.branchId;
  //  data['colors'] = this.colors;
   // data['quantity_stock'] = this.quantityStock;
    data['add_ons'] = this.addOns;
    data['ingredients'] = this.ingredients;
    //data['pricedisc'] = this.pricedisc;
    data['quantitychoise'] = this.quantitychoise;
    data['products'] = this.products;
    
   // data['addonchoise'] = this.addonchoise;
   // data['sizechoise'] = this.sizechoise;
    data['ingredientchoise'] =  this.ingredientchoise;
        data['PrixProduct'] =  this.PrixProduct;

    return data;
  }
} 


