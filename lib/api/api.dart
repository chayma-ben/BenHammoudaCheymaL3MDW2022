import 'dart:async';
import 'dart:convert';
//import 'package:flutter_caissenregistreuse_1/models/categoryProduct.dart';
//import 'package:flutter_caissenregistreuse_1/models/categoryProduct.dart';
import 'package:flutter_caissenregistreuse_1/models/categories.dart';
import 'package:flutter_caissenregistreuse_1/models/formules.dart';
import 'package:flutter_caissenregistreuse_1/models/order.dart';
//import 'package:flutter_caissenregistreuse_1/models/ingredient.dart';
import 'package:flutter_caissenregistreuse_1/models/products.dart';
import 'package:flutter_caissenregistreuse_1/models/addon.dart';
import 'package:flutter_caissenregistreuse_1/models/productsComp.dart';
import 'package:flutter_caissenregistreuse_1/models/restaurant.dart';
import 'package:flutter_caissenregistreuse_1/models/table.dart';
import 'package:flutter_caissenregistreuse_1/screens/home.dart';
import 'package:flutter_caissenregistreuse_1/widgets/cart.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;

class Network{
  final String _url = 'http://khazinav2.tannichm46.sg-host.com/api';
 
  final String _imgUrl='http://khazinav2.tannichm46.sg-host.com/storage/product/';


StreamController _controller = StreamController();
var idbranch;
  

  postData(data , apiUrl) async {
    var fullUrl = _url + apiUrl;
  return await  http.post(
    Uri.parse(fullUrl),
    headers:_setHeaders(),
    body: jsonEncode(data),
   );
  
}


_getId() async {
           SharedPreferences localStorage = await SharedPreferences.getInstance();
         user = localStorage.getString('branch-id') ?? "";
        var branch = user;
      return branch;
  }


_loadUserData() async {
    //SharedPreferences localStorage = await SharedPreferences.getInstance();
  //  var user = jsonDecode(localStorage.getString('branch')!);
    SharedPreferences localStorage = await SharedPreferences.getInstance();

 String user = localStorage.getString('branch') ?? "";
  if (user != "") {
  
  var branch = json.decode(user);  
     
        idbranch=branch[0]['id'];
   
  } 
  }

/************************Addon**************************/


 Future<List<Addon>> fetchAddon() async {
  final response = await http
      .get(Uri.parse(_url +'/addons'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
     dynamic res = jsonDecode(response.body);
      return (res as List).map((e) => Addon.fromJson(e)).toList();
   // return Ingredient.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Addons');
  }
} 



/* Future<List<Addon>> fetchAddon() async {
  final response = await http
      .get(Uri.parse(_url +'/addons'),);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
     dynamic result = jsonDecode(response.body);
    // _streamController.sink.add(result);
          DateTime.now().toIso8601String();
      return (result as List).map((e) => Addon.fromJson(e)).toList();
   // return Ingredient.fromJson(jsonDecode(response.body));

   
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ingredients');
  }


}  */

  

  
  Future<Restaurant> fetchRestaurant() async {
   // Response res = await get(postsURL);
 final response = await http
      .get(Uri.parse(_url +'/resto'));
    if (response.statusCode == 200) {
   dynamic res = jsonDecode(response.body);
        
      return res =  Restaurant.fromJson(res);
    } else {
      throw "Can't get posts.";
    }
  }  
  



Future<List<Product>> fetchFormule() async {
  final response = await http
      .get(Uri.parse(_url +'/formules'),);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
     dynamic result = jsonDecode(response.body);
      return (result as List).map((e) => Product.fromJson(e)).toList();
   // return Ingredient.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ingredients');
  }


} 



Future<List<Product>> fetchProductComp() async {
  final response = await http
      .get(Uri.parse(_url +'/composes'),);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
     dynamic result = jsonDecode(response.body);
      return (result as List).map((e) => Product.fromJson(e)).toList();
   // return Ingredient.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ingredients');
  }


} 



Future<List<TableModel>> fetchTable() async {
  final response = await http
      .get(Uri.parse(_url +'/table'),);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
     dynamic result = jsonDecode(response.body);
      return (result as List).map((e) => TableModel.fromJson(e)).toList();
   // return Ingredient.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ingredients');
  }


} 




Future<List<Order>> fetchOrder() async {
  final response = await http
      .get(Uri.parse(_url +'/order'),);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
     dynamic result = jsonDecode(response.body);
    return (result as List).map((e) => Order.fromJson(e)).toList();
   // return Ingredient.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ingredients');
  }


}  

  Future<List<Product>> fetchProduct() async {
   // Response res = await get(postsURL);
 final res = await http
      .get(Uri.parse(_url +'/products'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Product> productList = body
          .map(
            (dynamic item) => Product.fromJson(item),
          )
          .toList();

      return productList;
    } else {
      throw "Can't get posts.";
    }
  } 
 
Stream<List<Category>> fetchCategory1() async* {
   // Response res = await get(postsURL);
 final res = await http
      .get(Uri.parse(_url +'/products'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Category> productList = body
          .map(
            (dynamic item) => Category.fromJson(item),
          )
          .toList();
   for(var i =0 ; i<productList.length ; i++)
   {
     await Future.delayed(Duration(seconds: 2));
     yield productList.sublist(0,i+1);
   }
    }  
  } 
  Future<List<Category>> fetchCategory() async {
   // Response res = await get(postsURL);
 final res = await http
      .get(Uri.parse( _url +'/categories/'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Category> posts = body
          .map(
            (dynamic item) => Category.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }


/**************************    Login AND Logout ****************** */
  var token ;
  var user;
 /*_getToken() async {
 SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!);
    //jsonDecode("${localStorage.getString('token')}")['token'];
    
    return token;
  }*/
  
 _getToken() async {
   SharedPreferences localStorage = await SharedPreferences.getInstance();
      token = jsonDecode(localStorage.getString('token')!)['token'];
           return token;
  }
  

  
 
  
  authData(data, apiUrl) async {
 
    var fullUrl = _url + apiUrl;
    // print("response");
 
  final response =   await http.post(
        Uri.parse(fullUrl),
        headers: _setHeaders(),
   
        body: jsonEncode(data),
        
      
     );
   //  print("response");
     print(json.decode(response.body));
return await  response;
    //return await {}
  }

  getData(apiUrl) async {
  //  print("response");
    var fullUrl = _url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
        headers: _setHeaders(),
        
    );
    
  }




  getDataAll (apiUrl) async {

          var fullUrl = _url + apiUrl;

      http.Response response = await http.get(Uri.parse(fullUrl), 
      headers: _setHeaders());
    return json.decode(response.body);
    
   }
    

 paymentMethod()
  { 
     var payment_status;
 
    if(globals.payment_method == "espèce" || globals.payment_method == "Carte-bancaire")
     return payment_status = "paid"  ; 
 
   else 
   return payment_status = "unpaid";
 
  }  


  Calcul(){
  return globals.product; 
} 



 void cart() async{
       var idbranch = await _getId();
    var data = {
    //"prixTotal" : totalProduct,
           "order_amount" : globals.product,
           "order_status" : globals.status ,
         //"total_tax_amount" : total,
           "payment_status" : paymentMethod(),
           "order_type" : globals.order_type,
           "branch_id" :  int.parse(idbranch),
           "table_id" : globals.idtable,
          // "checked" : 1, 
           "cart" :[...globals.productlist.map((resmap)=>{"product_id" : resmap.id , "type" : resmap.type ,"price" : resmap.price,"quantity": resmap.quantitychoise,"tax_amount":  resmap.tax,"variant" : [], "variation" : resmap.variation, "add_on_ids" :  resmap.addonchoise,"add_on_qtys":  resmap.addonqtys, "discount_on_product": resmap.discount,"discount_type" :resmap.discountType, "list_choices" :resmap.selectedproducts,  "listchoices" :resmap.selectedingredient} )]
                       
    };
    var res = await  postData(data,'/order/place');
    print(data);
  } 



     
  _setHeaders() => {
  'Content-type' : 'application/json',
  'Accept' : 'application/json',
  'Authorization' : 'Bearer $token',
 // "Connection": "Keep-Alive",
  //"Keep-Alive": "timeout=5, max=1000"
 /* 'Access-Control-Allow-Origin':'*', // Required for CORS support to work
  //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
  "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  "Access-Control-Allow-Methods": "POST, OPTIONS,"*/
  };


}

