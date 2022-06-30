class Restaurant {
  String? restaurantName;
  String? restaurantOpenTime;
  String? restaurantCloseTime;
  String? restaurantLogo;
  String? restaurantAddress;
  String? restaurantPhone;
  String? restaurantEmail;
  int? minimumOrderValue;
  BaseUrls? baseUrls;
  String? currencySymbol;
  int? deliveryCharge;
  DeliveryManagement? deliveryManagement;
  String? cashOnDelivery;
  String? digitalPayment;
  String? termsAndConditions;
  String? privacyPolicy;
  String? aboutUs;
  bool? emailVerification;
  bool? phoneVerification;
  String? currencySymbolPosition;
  bool? maintenanceMode;
  String? country;
  bool? selfPickup;
  bool? delivery;

  Restaurant(
      {this.restaurantName,
      this.restaurantOpenTime,
      this.restaurantCloseTime,
      this.restaurantLogo,
      this.restaurantAddress,
      this.restaurantPhone,
      this.restaurantEmail,
      this.minimumOrderValue,
      this.baseUrls,
      this.currencySymbol,
      this.deliveryCharge,
      this.deliveryManagement,
      this.cashOnDelivery,
      this.digitalPayment,
      this.termsAndConditions,
      this.privacyPolicy,
      this.aboutUs,
      this.emailVerification,
      this.phoneVerification,
      this.currencySymbolPosition,
      this.maintenanceMode,
      this.country,
      this.selfPickup,
      this.delivery});

  Restaurant.fromJson(Map<String, dynamic> json) {
    restaurantName = json['restaurant_name'];
    restaurantOpenTime = json['restaurant_open_time'];
    restaurantCloseTime = json['restaurant_close_time'];
    restaurantLogo = json['restaurant_logo'];
    restaurantAddress = json['restaurant_address'];
    restaurantPhone = json['restaurant_phone'];
    restaurantEmail = json['restaurant_email'];
    minimumOrderValue = json['minimum_order_value'];
    baseUrls = json['base_urls'] != null
        ? new BaseUrls.fromJson(json['base_urls'])
        : null;
    currencySymbol = json['currency_symbol'];
    deliveryCharge = json['delivery_charge'];
    deliveryManagement = json['delivery_management'] != null
        ? new DeliveryManagement.fromJson(json['delivery_management'])
        : null;
    cashOnDelivery = json['cash_on_delivery'];
    digitalPayment = json['digital_payment'];
    termsAndConditions = json['terms_and_conditions'];
    privacyPolicy = json['privacy_policy'];
    aboutUs = json['about_us'];
    emailVerification = json['email_verification'];
    phoneVerification = json['phone_verification'];
    currencySymbolPosition = json['currency_symbol_position'];
    maintenanceMode = json['maintenance_mode'];
    country = json['country'];
    selfPickup = json['self_pickup'];
    delivery = json['delivery'];
  }

 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_open_time'] = this.restaurantOpenTime;
    data['restaurant_close_time'] = this.restaurantCloseTime;
    data['restaurant_logo'] = this.restaurantLogo;
    data['restaurant_address'] = this.restaurantAddress;
    data['restaurant_phone'] = this.restaurantPhone;
    data['restaurant_email'] = this.restaurantEmail;
    data['minimum_order_value'] = this.minimumOrderValue;
    if (this.baseUrls != null) {
      data['base_urls'] = this.baseUrls!.toJson();
    }
    data['currency_symbol'] = this.currencySymbol;
    data['delivery_charge'] = this.deliveryCharge;
    if (this.deliveryManagement != null) {
      data['delivery_management'] = this.deliveryManagement!.toJson();
    }
    data['cash_on_delivery'] = this.cashOnDelivery;
    data['digital_payment'] = this.digitalPayment;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['privacy_policy'] = this.privacyPolicy;
    data['about_us'] = this.aboutUs;
    data['email_verification'] = this.emailVerification;
    data['phone_verification'] = this.phoneVerification;
    data['currency_symbol_position'] = this.currencySymbolPosition;
    data['maintenance_mode'] = this.maintenanceMode;
    data['country'] = this.country;
    data['self_pickup'] = this.selfPickup;
    data['delivery'] = this.delivery;
    return data;
  }
}

class BaseUrls {
  String? restaurantImageUrl;
  String? productImageUrl;
  String? customerImageUrl;
  String? bannerImageUrl;
  String? categoryImageUrl;
  String? reviewImageUrl;
  String? notificationImageUrl;
  String? deliveryManImageUrl;
  String? chatImageUrl;

  BaseUrls(
      {this.restaurantImageUrl,
      this.productImageUrl,
      this.customerImageUrl,
      this.bannerImageUrl,
      this.categoryImageUrl,
      this.reviewImageUrl,
      this.notificationImageUrl,
      this.deliveryManImageUrl,
      this.chatImageUrl});

  BaseUrls.fromJson(Map<String, dynamic> json) {
    restaurantImageUrl = json['restaurant_image_url'];
    productImageUrl = json['product_image_url'];
    customerImageUrl = json['customer_image_url'];
    bannerImageUrl = json['banner_image_url'];
    categoryImageUrl = json['category_image_url'];
    reviewImageUrl = json['review_image_url'];
    notificationImageUrl = json['notification_image_url'];
    deliveryManImageUrl = json['delivery_man_image_url'];
    chatImageUrl = json['chat_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_image_url'] = this.restaurantImageUrl;
    data['product_image_url'] = this.productImageUrl;
    data['customer_image_url'] = this.customerImageUrl;
    data['banner_image_url'] = this.bannerImageUrl;
    data['category_image_url'] = this.categoryImageUrl;
    data['review_image_url'] = this.reviewImageUrl;
    data['notification_image_url'] = this.notificationImageUrl;
    data['delivery_man_image_url'] = this.deliveryManImageUrl;
    data['chat_image_url'] = this.chatImageUrl;
    return data;
  }
}

class DeliveryManagement {
  int? status;
  int? minShippingCharge;
  int? shippingPerKm;

  DeliveryManagement({this.status, this.minShippingCharge, this.shippingPerKm});

  DeliveryManagement.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    minShippingCharge = json['min_shipping_charge'];
    shippingPerKm = json['shipping_per_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['min_shipping_charge'] = this.minShippingCharge;
    data['shipping_per_km'] = this.shippingPerKm;
    return data;
  }
}