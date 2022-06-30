import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
//import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/models/formules.dart';
import 'package:flutter_caissenregistreuse_1/models/products.dart';
import 'package:flutter_caissenregistreuse_1/models/productsComp.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart'; 
//import 'package:http/http.dart' as http;
 import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';




class Cart with ChangeNotifier {
  List<Product> products = [];
var totalCartValue = 0.0;

 
     
  double get totalTax {
    return products.fold(0.0, (double currentTotal, Product nextProduct) {
      return  (currentTotal + nextProduct.tax!) ;
       
    });
  } 

  double get totalProduct {
    return products.fold(0.0, (double currentTotal, Product nextProduct) {
      return (currentTotal + nextProduct.PrixProduct! ) ;
    });
  } 

   double get subtotal
{
  return products.fold(0.0, (double currentTotal, Product nextProduct) {
      return (currentTotal + ((nextProduct.prix!  *nextProduct.quantitychoise) /* + nextProduct.addonquantity */)) ;
    });
}  

  double get total
{
 return products.fold(0.0, (currentTotal, item) {
  
      return  ((currentTotal + (item.tax!/100)*item.prix!  +  ((item.prix! )   *  item.quantitychoise ) /*  +item.addonquantity */)) ;
 }); 
  }

void calculateTotal (){
    totalCartValue = 0;
    for (var product in products) {
     totalCartValue += product.PrixProduct! * product.quantitychoise;
    }
  } 


void updateProduct(product, qty ) {
    int index = products.indexWhere((i) => i.id == product.id && i.namesize == product.namesize && i.selectedproducts == product.selectedproducts && i.selectedingredient == product.selectedingredient  /* && i.addonname  == product.aaddonname */ );
  products[index].quantitychoise = qty;
    notifyListeners();
  }

  void updateProduct1(product, qty, aqty ) {
    int index = products.indexWhere((i) => i.id == product.id && i.namesize == product.namesize && i.selectedproducts == product.selectedproducts && i.selectedingredient == product.selectedingredient   && i.addonname == product.addonname  );
  products[index].quantitychoise = qty;
  products[index].addonquantity = aqty;
    notifyListeners();
  }


  void addToCart(Product product) {
  
    int index = products.indexWhere((i) => i.id == product.id && i.namesize == product.namesize && i.selectedproducts == product.selectedproducts && i.selectedingredient == product.selectedingredient  && i.addonname == product.addonname );
    
    if (index != -1)
    { 
    products[index].quantitychoise = products[index].quantitychoise + product.quantitychoise;
      updateProduct(product,  products[index].quantitychoise);
    }
    else {
      products.add(product);
    //  calculateTotal();
      notifyListeners();
     // print(product.quantitychoise);
     print(total);
  }  

 
  } 

    void addToQuantity(Product product) {
  
    int index = products.indexWhere((i) => i.id == product.id && i.namesize == product.namesize && i.selectedproducts == product.selectedproducts && i.selectedingredient == product.selectedingredient  && i.addonname   == product.addonname );
    
    if (index != -1)
    { 
     products[index].quantitychoise ++;
     
      updateProduct1(product,  products[index].quantitychoise,products[index].addonquantity);
    }
   
      notifyListeners();
  }

    void removeFromCart(Product product) {
   int index = products.indexWhere((i) => i.id == product.id  && i.namesize == product.namesize && i.selectedproducts == product.selectedproducts && i.selectedingredient == product.selectedingredient   && i.addonname  == product.addonname  );
 products[index].quantitychoise--;
   if (index != -1)
   updateProduct1(product,products[index].quantitychoise,products[index].addonquantity);
    if (products[index].quantitychoise == 0)
      products.remove(product);
  //products.removeWhere((item) => item.id == product.id && item.namesize == product.namesize );
   // products.remove(product);
 
    notifyListeners();
  } 

   void removeFromCart1 (Product product) {
  
   products.remove(product);
 
    notifyListeners();
  } 


  void removeCart(){
    products.clear( );
 //   formules.clear();
  //   productscomps.clear();
      notifyListeners();
  }

} 

class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   //  var bloc = Provider.of<Cart>(context);
   // var carts = bloc.cart;
    return Scaffold(
      body: Consumer<Cart>(
        builder: (BuildContext context, Cart cart, Widget ) {
          return 
             Column(
              children: [
                   Expanded(
                      child: Container(
                       // padding: const EdgeInsets.only(top :10),
                         color: Color(0xffF1F7FC),

                        child: ListView.builder(
                          itemCount: cart.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = cart.products[index];  
                           globals.productlist =  cart.products; 
                            globals.productId = item.id;
                            globals.PrixProduct = item.PrixProduct;
                            globals.quantity = item.quantitychoise;
                            globals.variation = item.variation;
                            globals.addonids = item.addonchoise;
                            globals.addonqtys= item.addonqtys;
                               
                        
                            return Container(
                              margin: const EdgeInsets.only(top:5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                     ),
                              child: ListTile(
                                title: Text(item.name  ?? ''),
                                subtitle: Column(
                                  children: [
                                   if(item.sizechoise != null)
                                  Text('taille :${item.namesize.toString() } '),
                                 //if(item.addonchoise!.isNotEmpty)
                               // Text('addon : ${item.addonchoise.toString()} quantity : ${item.addonqtys}')
                                Text('cost: ${item.prix!.toStringAsFixed(2).toString()}'),
                                
                                 if(item.tax != 0 )
                                    Text('tax :${item.tax.toString() } '),

                                    // if(item.selectedingredient !="" )
                                    //Text('ingredients:${item.selectedingredient.toString() } '),

                                    
                                   // if(item.selectedproducts !="" )
                                   // Text('products :${item.selectedproducts.toString() } '),
                                  ], 
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                   /*  RaisedButton(
                                      onPressed: 
                                      (){
                                         context.read<Cart>().updateProduct(item,
                                            item.quantitychoise - 1);
                                      }, 
                                      
                                      child:*/ 
                                       IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                 context.read<Cart>().removeFromCart(item);
                              },
                             ),
                                      
                                      Text((item.quantitychoise).toString()),
                                              IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () {
                                 context.read<Cart>().addToQuantity(item);
                              },
                             ),
                                   
                                  ],
                                ),
                                  
                              /*  onTap: () {
                                  context.read<Cart>().removeFromCart(item);
                                }, */
                              ),
                            );

                            
                          },
                        ),
                      ),
                    ),

            Divider( 
                 
              height: MediaQuery.of(context).size.height * 0.001,
                          color: Colors.black,
                          thickness: 1,),
                   Column(
                     children: [
                       Row(
                        children: [
                          Padding(padding: const EdgeInsets.only(left: 10)),
                  
                          Text(
                            "SubTotal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Spacer(),
                           Divider(),
                  Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${context.select((Cart c) => c.
                          subtotal)}',
                          
                        ),
                  )
                        ],
                  ),
                        Row(
                        children: [
                          Padding(padding: const EdgeInsets.only(left: 10)),
                  
                          Text(
                            "Tax",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Spacer(),
                           Divider(),
                  Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${context.select((Cart c) => c.
                          totalTax)}',
                          
                        ),
                  )
                        ],
                  ),

                   Visibility(
                    visible: false,
                     child: Row(
                          children: [
                            Padding(padding: const EdgeInsets.only(left: 10)),
                                     
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            Spacer(),
                             Divider(),
                                     Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${globals.product = context.select((Cart c) => c.total.toStringAsFixed(2))}',
                            
                          ),
                                     )
                                     
                          ],
                                     ),
                   ),
                     ],
                   ),
            ],
          );


          

        },
        
      ),
    );
  }

    }




 