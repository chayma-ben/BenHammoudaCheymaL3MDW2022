
import 'package:flutter_caissenregistreuse_1/models/products.dart';

class Order {
  int? id;
  int? userId;
  double? orderAmount;
  int? couponDiscountAmount;
  String? paymentStatus ;
  String? orderStatus;
  int? totalTaxAmount;
  String? paymentMethod;
 // Null? transactionReference;
 // Null? deliveryAddressId;
  String? createdAt;
  String? updatedAt;
  int? checked;
 // Null? deliveryManId;
 // int? deliveryCharge;
 // Null? orderNote;
 // Null? couponCode;
  String? orderType;
  int? branchId;
//  Null? callback;
 // Null? deliveryDate;
 // Null? deliveryTime;
  String? extraDiscount;
  int? tableId;
  int? tablenum;
  List<Product>? productlist;

  Order(
      {this.id,
      this.userId,
      this.orderAmount,
      this.couponDiscountAmount,
      this.paymentStatus,
      this.orderStatus,
      this.totalTaxAmount,
      this.paymentMethod,
     // this.transactionReference,
     // this.deliveryAddressId,
      this.createdAt,
      this.updatedAt,
      this.checked,
    //  this.deliveryManId,
     // this.deliveryCharge,
     // this.orderNote,
     // this.couponCode,
      this.orderType,
      this.branchId,
     // this.callback,
     /// this.deliveryDate,
     // this.deliveryTime,
      this.extraDiscount,
      this.tableId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
   orderAmount = json['order_amount']+0.0;
    couponDiscountAmount = json['coupon_discount_amount'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount'];
    paymentMethod = json['payment_method'];
  //  transactionReference = json['transaction_reference'];
   // deliveryAddressId = json['delivery_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    checked = json['checked'];
   // deliveryManId = json['delivery_man_id'];
   // deliveryCharge = json['delivery_charge'];
   // orderNote = json['order_note'];
  //  couponCode = json['coupon_code'];
    orderType = json['order_type'];
    branchId = json['branch_id'];
  //  callback = json['callback'];
   // deliveryDate = json['delivery_date'];
   // deliveryTime = json['delivery_time'];
    extraDiscount = json['extra_discount'];
    tableId = json['table_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
   data['order_amount'] = this.orderAmount;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['payment_method'] = this.paymentMethod;
  //  data['transaction_reference'] = this.transactionReference;
  //  data['delivery_address_id'] = this.deliveryAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['checked'] = this.checked;
   // data['delivery_man_id'] = this.deliveryManId;
    //data['delivery_charge'] = this.deliveryCharge;
   // data['order_note'] = this.orderNote;
   // data['coupon_code'] = this.couponCode;
    data['order_type'] = this.orderType;
    data['branch_id'] = this.branchId;
   // data['callback'] = this.callback;
   // data['delivery_date'] = this.deliveryDate;
   // data['delivery_time'] = this.deliveryTime;
    data['extra_discount'] = this.extraDiscount;
    data['table_id'] = this.tableId;
    return data;
  }
}