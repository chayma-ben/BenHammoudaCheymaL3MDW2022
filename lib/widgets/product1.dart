import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;
import 'package:flutter_caissenregistreuse_1/models/addon.dart';
import 'package:flutter_caissenregistreuse_1/models/categories.dart';
import 'package:flutter_caissenregistreuse_1/models/formules.dart';
import 'package:flutter_caissenregistreuse_1/models/ingredient.dart';
import 'package:flutter_caissenregistreuse_1/models/products.dart';
import 'package:flutter_caissenregistreuse_1/screens/home.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'cart.dart';

class Product1 extends StatefulWidget {
  var values;


  Product1({Key? key, required this.values}) : super(key: key);

  @override
  _Product1State  createState() => _Product1State();
  /*final StreamController<List<Product>> _streamController = StreamController<List<Product>>();
  Stream<List<Product>> get allProductsForSale => _streamController.stream;*/


}

class _Product1State extends State<Product1> {

 /*    void dispose() {
    _streamController.close();
  } */

  var imgUrl = "http://khazinav2.tannichm46.sg-host.com/storage/product/";
  // var _imgUrl = "http://127.0.0.1:8000/storage/ingredient/";
  var imgUrlAddon = "http://khazinav2.tannichm46.sg-host.com/storage/addon/";

  var number;
 var  random;
   int id = 0;
  @override
  List<Product> products = [];
  List<Product> productfordisplay = [];
  Product newproduct = new Product();
  void initState() {
    //super.initState();
    //_getProducts();

    Network().fetchAddon().then((value) => {
          if (value.isNotEmpty)
            { 
              if(mounted){
              setState(() {
                addonListe.addAll(value);
              })
            }
            }
        });  
    Network().fetchProduct().then((value) => {
      if(mounted){
          setState(() {
            random = Random().nextInt(2000);
            products.addAll(value);
            productfordisplay = products;
          })
      }
        });
  }
  void addtocart(produit){

   produit.type = "product";
      context
    .read<Cart>()
    .addToCart(produit);

  
    /*  Network().fetchProduct().then((value) => {
       setState(() {
          
            productfordisplay = value;
        })
        });*/
 
Navigator.pop(context,true);
  }

  //var valueFilter;
  List<int> addOnQuantity = List.filled(10000, 0);
  List<int> productQuantity = List.filled(10000, 1);
  List<Ingredient> ingrediantsListe = [];
  List<Addon> addonListe = [];

  //List<num> newPrice = List.filled(10000,1);
  //List<num> addonPrice = List.filled(10000,0);

//var Quantityproduct ;
  var totaladdons;
  var listaddon;
   var finalPrice;
  //    var PrixTotal ;
  // bool _hasBeenPressed= false;

  //var priceprod;
  //var finalprix;
  //var valueFilter ;

  bool isChecked = true;
  //var isShow=false;

//var priceWithAddon;
  @override
  Widget build(BuildContext context) {
    //print(widget.values);

    return Container(
        // width : MediaQuery.of(context).size.width*
        height: MediaQuery.of(context).size.height * 0.9,
        child :Wrap(
            
            children: List.generate(
             productfordisplay.length+1,
                (index) { 
        return index == 0 ? _searchbar() :  _productList(index-1);
  
      } )
        )
    );
  }

  Widget _searchbar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        // onChanged: (_) => setState(() {}),

        decoration: InputDecoration(
            //  filled: true,
            fillColor: Colors.white24,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey[350]),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hoverColor: Colors.transparent,
            suffixIcon: Container(
                height: MediaQuery.of(context).size.height * 0.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: IconButton(
                    icon: Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //debugPrint('222');
                    }))),

        onChanged: (text) {
          text = text.toLowerCase();
          if(mounted){
          setState(() {
            productfordisplay = products.where((element) {
              var productname = element.name?.toLowerCase();
              return productname.toString().contains(text);
            }).toList();
          });
          }
        },
      ),
    );
  }

  Widget _productList(index) {
    //final product = products[index];
//print(products[index]);
    //print(product);
 
    totaladdons = 0;
    var product = productfordisplay[index];


     discount() {
      if (product.discountType == 'percent') {
        var pricedisc =
            product.price! - (product.price! * product.discount! / 100);
        return pricedisc;
      } else {
        var pricedisc =  product.price! - product.discount!;
        return pricedisc;
      }
    }

     var productcat =jsonDecode(product.categoryIds!);
    

    var Prixproduct = product.price! - discount() ;

/* filtre(){
                           for(var index = 0;index<productcat.length ; index++)
            { 
            var id  = productcat[index]['id'];
             print(id);
             return id;
            
              
            } 
} */

    
    var addonid;

    if (widget.values == 0) {
             
    
   /*   return  StreamProvider<List<Product>>(
        initialData: [],
        create: (_) => Provider.of<Product1>(context).allProductsForSale,
        catchError: (BuildContext context, error) => <Product>[],
        updateShouldNotify: (List<Product> last, List<Product> next) => last.length == next.length,
        builder: (BuildContext context, Widget) {*/
      return Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.15,
          child:   
         Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: GestureDetector(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      Image.network(
                        imgUrl + productfordisplay[index].image!,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Column(
                        children: [
                          Text(
                            productfordisplay[index].name!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(3)),
                       if ( product.discount! > 0)
                                      Column(children: [
                                        Text(
                                          "${ product.price.toString()} ${globals.restaucurrency}",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          "${discount()} ${globals.restaucurrency}",
                                        )
                                      ]) 
                      else
                      Text(
                        "${productfordisplay[index].price.toString()} ${globals.restaucurrency}",
                      ),
                    ],
                  ),
                  onTap: () => {
                        //print(v.length),
newproduct = productfordisplay[index],
    modalproduct(newproduct,context),
    print (productcat.runtimeType),
        Network().fetchProduct().then((value) => {
          if(mounted){
       setState(() {
          
            productfordisplay = value;
        })}
        }), 


     // {}
       //  showProductComposeDialog(),
                        productQuantity = List.filled(10000, 1),

                        addOnQuantity = List.filled(10000, 0),
                        totaladdons = 0,
                        newproduct.quantitychoise = 1,
                        newproduct.addonquantity = 0,

                        // product.PrixProduct = product.price,
                        newproduct.addonchoise = [],
                        //  product.namesize= size[0]['type'],

                      })));
    }
    
    else if(productcat.toString().contains(widget.values.toString()))
     {
       return Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.15,
          child:   
         Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: GestureDetector(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      Image.network(
                        imgUrl + productfordisplay[index].image!,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Column(
                        children: [
                          Text(
                            productfordisplay[index].name!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(3)),
                       if ( product.discount! > 0)
                                      Column(children: [
                                        Text(
                                          "${ product.price.toString()} ${globals.restaucurrency}",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          "${  discount()} ${globals.restaucurrency}",
                                        )
                                      ]) 
                      else
                      Text(
                        "${productfordisplay[index].price.toString()} ${globals.restaucurrency}",
                      ),
                    ],
                  ),
                  onTap: () => {
                        //print(v.length),
newproduct = productfordisplay[index],
    modalproduct(newproduct,context),
     Network().fetchProduct().then((value) => {
      if(mounted){
       setState(() {
            productfordisplay = value;
        })}
        }), 

     // {}
       //  showProductComposeDialog(),
                        productQuantity = List.filled(10000, 1),

                        addOnQuantity = List.filled(10000, 0),
                        totaladdons = 0,
                        newproduct.quantitychoise = 1,
                        newproduct.addonquantity = 0,

                        // product.PrixProduct = product.price,
                        newproduct.addonchoise = [],
                        //  product.namesize= size[0]['type'],

                      })));

     }
    
    else
      return SizedBox();


  }





  
 void modalproduct (produit,context1) {



       discount() {
      if (produit.discountType == 'percent') {
        var pricedisc =
            produit.price! - (produit.price! * produit.discount! / 100);
        return pricedisc;
      } else {
        var pricedisc =  produit.price! - produit.discount!;
        return pricedisc;
      }
    }
   
    var Prixproduct = produit.price;
   

    List<dynamic> v;

    v = jsonDecode(produit.ingredients!);

    List<bool> isSelectedIngred = List<bool>.filled(v.length, true);

    

    List<dynamic> size;
    size = jsonDecode(produit.variations!);
    List<bool> isSelected = List<bool>.filled(size.length, false);
    List<dynamic> addon;
    addon = jsonDecode(produit.addOns!);

    for (var loop = 0; loop < isSelected.length; loop++) {
      isSelected[0] = true;

      if (size.length > 0) {
        Prixproduct = produit.price ;
        //  print(size[0]['price'].runtimeType);
        produit.sizechoise = Prixproduct;
        //  Prixproduct =
        produit.namesize = size[0]['type'];
        produit.variation = [
          {"type": "${produit.namesize}", "price": "${Prixproduct}"}
        ];
      }
    }



    // produit.PrixProduct = (produit.sizechoise! * produit.quantitychoise!);

    calculer() {
     // produit.quantitychoise ??= 1;
      produit.addonquantity ??= 0;

      if (size.length > 0) {
        produit.PrixProduct =
            Prixproduct! * produit.quantitychoise! +
               (produit.addonquantity! * produit.quantitychoise!);
                produit.prix = Prixproduct! +  produit.addonquantity!  ;
                 produit.cost = Prixproduct;
  
       // print(produit.addonquantity);
      } else if(produit.discount >0)
      {
         produit.PrixProduct =
          discount() * produit.quantitychoise! +
                produit.addonquantity! ;
                produit.prix = discount() +  produit.addonquantity! ;
                produit.cost=discount();
             
      }
      
      
      else {
        produit.PrixProduct =
           produit.price! * produit.quantitychoise! +
               (produit.addonquantity! * produit.quantitychoise!);
                produit.prix =Prixproduct! +  produit.addonquantity! ;
                 print("produit.prix : " +produit.prix.toString());
  
      } 
      
    //  print(produit.PrixProduct!);

      return produit.PrixProduct!.toStringAsFixed(2);
    }

                        showDialog(
                          context: context1,
                            builder: (_) {
                              return AlertDialog (content: StatefulBuilder(
                              builder:
                                      (BuildContext context1, StateSetter setState) {
                                return Container(
                                  width:
                                      MediaQuery.of(context1).size.width * 0.3,
                                  child: Wrap(
                                    children: [
                                      Center(
                                        child: Image.network(
                                          imgUrl + produit.image!,
                                          fit: BoxFit.contain,
                                          width: MediaQuery.of(context1)
                                                  .size
                                                  .width *
                                              0.15,
                                          height: MediaQuery.of(context1)
                                                  .size
                                                  .height *
                                              0.15,
                                        ),
                                      ),
                                      Center(
                                        child: Column(children: [
                                          Text(
                                            produit.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                           if ( produit.discount! > 0)
                                      Column(children: [
                                        Text(
                                          "${  discount()} ${globals.restaucurrency}",
                                        )
                                      ]) 
                                      else
                                          Text(
                                            "${Prixproduct!.toString()}",
                                          ),
                                          /*  if(product.description!.isNotEmpty)
                                                        Row(children: [
                                                          Text(
                                                            "Description",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold),
                                                          )
                                                        ]),
                                                        Row(
                                                          children: [
                                                            Text(product.description.toString()),
                                                          ],
                                                        ),  */
                                        ]),
                                      ),

                                      
                                          if (size.length > 0)
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                  const  Text("Size" + "\n",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                  ]),
                                              ],
                                            ),
                                               if (size.length > 0)
                                               Padding(
                                                 padding: const EdgeInsets.only(bottom :8.0),
                                                 child: ButtonTheme(
                                                      minWidth: 45,
                                                      height: 45,
                                                      child: ToggleButtons(
                                                        isSelected: isSelected,
                                                        selectedColor:
                                                            Colors.black,
                                                        color: Colors.black,
                                                     fillColor: Colors.orange[300],
                                                      renderBorder: false,
                                                     // selectedBorderColor: Colors.black,
                                                    // borderColor : Colors.transparent,
                                                        highlightColor:
                                                            Colors.orange,
                                                        children: <Widget>[
                                                          for (var i = 0;
                                                              i < size.length;
                                                              i++)
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          12),
                                                              child: Text(
                                                                  size[i]['type'],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18)),
                                                            ),
                                                        ],
                                                        onPressed:
                                                            (int newIndex) {
                                                          setState(() {
                                                            for (int index = 0;
                                                                index <
                                                                    isSelected
                                                                        .length;
                                                                index++) {
                                                              if (index ==
                                                                  newIndex) {
                                                                isSelected[
                                                                    index] = true;
                                                                Prixproduct =
                                                                    size[index]
                                                                        ['price'] + 0.0;
                                                                produit
                                                                        .sizechoise =
                                                                    Prixproduct;
                                                                produit
                                                                        .namesize =
                                                                    size[index]
                                                                        ['type'];
                                                                Prixproduct =
                                                                    size[index]
                                                                        ['price'] + 0.0;
                                                                /*  product.sizechoise=  Prixproduct;
                      product.namesize = size[index]['type'];  */
                                                                produit
                                                                    .variation = [
                                                                  {
                                                                    "type":
                                                                        "${produit.namesize}",
                                                                    "price":
                                                                        "${Prixproduct}"
                                                                  }
                                                                ];
                                                            //  print(produit.namesize);
                                                              } else {
                                                                isSelected[
                                                                        index] =
                                                                    false;
                                                              }
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                               ),
                                               
                                             
                                    

                                      if (v.length > 0)
                                        Row(
                                          children: [
                                             Text("Ingredients " + "\n",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    
                                              if (v.length > 0)
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom :8.0),
                                                child: ToggleButtons(
                                                  /* color:  Colors.amber,
                                                                                             onPressed: () { 
                                                                                               setState(() {
                                                                                           print(size[0]['price']);
                                                                                                 });
                                                                                             },
                                                                                             child: 
                                                                                             Text((size[1]['type']),style: TextStyle(fontSize: 15,)),*/
                                                  isSelected: isSelectedIngred,
                                                  selectedColor: Colors.black,
                                                  color: Colors.black,
                                                  fillColor:
                                                      Colors.orange[300],
                                                      
                                                  // selectedBorderColor: Colors.black,
                                                   // borderColor : Colors.black,
                                                  renderBorder:true,
                                                  highlightColor: Colors.orange,
                                                  children: <Widget>[
                                            
                                                    for (var i = 0;
                                                        i < v.length;
                                                        i++)
                                            
                                                      Padding(
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 12),
                                                          child: Text(v[i],
                                                              style: TextStyle(
                                                                  fontSize: 18))),
                                                  ],
                                                  onPressed: (int newIndex) {
                                                    setState(() {
                                                      for (int index = 0;
                                                          index <
                                                              isSelectedIngred
                                                                  .length;
                                                          index++) {
                                                        if (index == newIndex) {
                                                          isSelectedIngred[index] =
                                                              !isSelectedIngred[
                                                                  index];
                                                          // print(v[i]['name'][index]);
                                                          //   product.ingredientchoise = [{"ingredient" : "${v}"}];
                                                          //  print(product.ingredientchoise);
                                                          //   isSelectedIngred[index] = false;
                                                          //  if(isSelectedIngred[index])
                                                          //   {
                                                          //   product.ingredientchoise= [{"ingredient" : "${v[index]['name']}"}];
                                                          //  print(product.ingredientchoise);
                                                        } else {
                                                          //product.ingredientchoise!.removeAt(index);
                                                          // print(product.ingredientchoise);
                                                        }
                                                      }
                                                    }
                                                        /*  for (int index = 0; index < isSelectedIngred.length; index++) {
                                                                                                  if (index == newIndex) {
                                                                                                   product.ingredientchoise = [{"ingredient" : "${v}"}];
                                                                                                   print(product.ingredientchoise);
                                                                                                    isSelectedIngred[index] = false;
                                                                                                   if(isSelectedIngred[index])
                                                                                                    {
                                                                                                    product.ingredientchoise= [{"ingredient" : "${v[index]['name']}"}];
                                                                                                  //  print(product.ingredientchoise);
                                                                                                    }else{
                                                                                                    product.ingredientchoise!.removeAt(index);
                                                                                                    // print(product.ingredientchoise);
                                                                                                    }
                                                                                                  }
                                                                                                }*/
                                                        );
                                                  },
                                                ),
                                              ),
                                            ),

                                             

                                            // ),

                                           // ),
                                         
   Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Quantité",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  /*    if (productQuantity[
                                                                              snapshot.data[
                                                                                      index]
                                                                                  ['id']] ==
                                                                          1) {
                                                                        if (snapshot.data[
                                                                                    index]
                                                                                [
                                                                                'discount'] >=
                                                                            0) {
                                                                          newPrice[snapshot
                                                                                      .data[
                                                                                  index][
                                                                              'id']] = productQuantity[
                                                                                  snapshot.data[index]
                                                                                      [
                                                                                      'id']] *
                                                                              (snapshot.data[index]
                                                                                      [
                                                                                      'price'] -
                                                                                  discount());
                                                                                  
                                                                        } else
                                                                          newPrice[snapshot.data[index]['id']] = productQuantity[
                                                                                  snapshot.data[index]
                                                                                      [
                                                                                      'id']] *
                                                                              snapshot.data[
                                                                                      index]
                                                                                  [
                                                                                  'price'];
                                              
                                                                      }*/

                                                  setState(() {
                                                    //Changed here
                                                    productQuantity[
                                                        produit.id!]--;

                                                    /* if (productQuantity[snapshot.data[index]['id']] <1) {
                                                                          productQuantity[ snapshot.data[index] ['id']] = 1;
                                                                          print(PrixTotal);
                                                                        }
                                                                        // if (snapshot.data[index]['discount'] >=0) {
                                                                         /* newPrice[snapshot
                                                                                      .data[
                                                                                  index][
                                                                              'id']] = productQuantity[
                                                                                  snapshot.data[index]
                                                                                      [
                                                                                      'id']] *
                                                                              snapshot.data[index]
                                                                                      [
                                                                                      'price'];*/
                                                                                  PrixTotal =  productQuantity[
                                                                                  snapshot.data[index]
                                                                                      [
                                                                                      'id']] * PrixTotal ;*/

                                                    if (productQuantity[
                                                            produit.id!] <
                                                        1) {
                                                      productQuantity[
                                                          produit.id!] = 1;
                                                    } else {
                                                      //product.price
                                                      /*    finalPrice= productQuantity[
                                                                                  product.id!] * Prixproduct!; */
                                                      //  print(finalPrice);
                                                      // PrixTotal = finalPrice;
                                                    }
                                                    produit.quantitychoise =
                                                        productQuantity[
                                                            produit.id!];
                                                    //  print(product.quantitychoise);
                                                    // } else

                                                    /*PrixTotal = productQuantity[
                                                                                  snapshot.data[index]
                                                                                      [
                                                                                      'id']] *PrixTotal
                                                                                    /*  newPrice[snapshot
                                                                                      .data[
                                                                                  index][
                                                                              'id']] */ ;
                                                                              print(PrixTotal);*/
                                                    /*   productQuantity[snapshot.data[index]['id']]--;
   
                                                                                   if(productQuantity[snapshot.data[index]['id']]<1)
                                                                                   { 
                                                                                      productQuantity[snapshot.data[index] ['id']] = 1;
                                                                                      print(PrixTotal);
                                                                                   
                                                                                   }
                                                                                   else
                                                                                   {
                                                                                     PrixTotal= productQuantity[
                                                                                  snapshot.data[index]
                                                                                      [
                                                                                      'id']] *PrixTotal;
                                                                                   }*/
                                                  });
                                                },
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                //Changed here
                                                productQuantity[produit.id!]
                                                    .toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    //Changed here
                                                    productQuantity[
                                                        produit.id!]++;

                                                    //product.price
                                                    /*  finalPrice  = productQuantity[
                                                                                  product.id!] * Prixproduct!; */

                                                    produit.quantitychoise =
                                                        productQuantity[
                                                            produit.id!];
                                                    // print(product.quantitychoise);
                                                  });
                                                },
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 15,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (addon.length > 0)
                                       
                                         Row(children: const [
                                          Text("Addon" + "\n",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                          ]),
                                        
                                      if (addon.length > 0)
                                        Container(
                                          // width : MediaQuery.of(context1).size.width*
                                          height: MediaQuery.of(context1)
                                                  .size
                                                  .height *
                                              0.2,
                                          child: ListView.builder(
                                            // Let the ListView know how many items it needs to build.
                                            itemCount: addonListe.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            // Provide a builder function. This is where the magic happens.
                                            // Convert each item into a widget based on the type of item it is.
                                            itemBuilder: (context1, index) {
                                              final item = addonListe[index];
                                              var addonid = addonListe[index].id;
                                              //listaddon = products.where((element) => element.addOns.toString().contains()).toList();
                                              //print(listaddon);

                                              if (produit.addOns
                                                  .toString()
                                                  .contains(
                                                      addonid.toString())) {
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    side: BorderSide(
                                                      color: isChecked
                                                          ? Colors.grey
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        imgUrlAddon +
                                                            item.image!,
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                    context1)
                                                                .size
                                                                .width *
                                                            0.07,
                                                        height: MediaQuery.of(
                                                                    context1)
                                                                .size
                                                                .height *
                                                            0.07,
                                                      ),
                                                      Text(
                                                        item.name.toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: isChecked
                                                              ? Colors.black
                                                              : Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        item.price.toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: isChecked
                                                              ? Colors.black
                                                              : Colors.grey,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                //Changed here
                                                                addOnQuantity[
                                                                    item.id!]--;
                                                                if (addOnQuantity[
                                                                        item.id!] <
                                                                    0) {
                                                                  addOnQuantity[
                                                                      item.id!] = 0;
                                                                } else {
                                                                  totaladdons =
                                                                      item.price;
                                                                  // print(item.price);
                                                                  // print(" totaladdons : $totaladdons");
                                                                  // product.addonquantity= totaladdons as double;
                                                                  // product.addonchoise = [{ "name":"${item.name}"},{"price" : "${item.price}"},{"quantity" : "${addOnQuantity[item.id!]}"}];

                                                                  produit
                                                                      .addonquantity = addOnQuantity[
                                                                          item.id!] *
                                                                      item.price!;
                                                                  produit
                                                                      .PrixProduct = produit
                                                                          .addonquantity! +
                                                                      produit
                                                                          .PrixProduct!;
                                                                  produit
                                                                          .addonqtys =
                                                                      addOnQuantity[
                                                                          item.id!];

                                                                  produit
                                                                      .addonchoise = [
                                                                    {
                                                                      "name":
                                                                          "${item.name}"
                                                                    },
                                                                    {
                                                                      "price":
                                                                          "${item.price}"
                                                                    }
                                                                  ];

                                                                  produit.addonname= item.name;
                                                                  // product.addonquantity= totaladdons ;
                                                                  // print( product.addonchoise);
                                                                  // product.addonchoise=listaddon;
                                                                  //   print(product.addonchoise);
                                                                  //  print(product.addonchoise.runtimeType);
                                                                  //print(listaddon);
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 25,
                                                              height: 25,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle),
                                                              child: Icon(
                                                                Icons.remove,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            //Changed here
                                                            addOnQuantity[
                                                                    item.id!]
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                //Changed here
                                                                addOnQuantity[
                                                                    item.id!]++;
                                                                // item.price =  snapshot.data[index]['price'];
                                                                totaladdons =
                                                                    item.price!;
                                                                finalPrice =
                                                                    addOnQuantity[
                                                                        item.id!];
                                                                // print("finalPrice $finalPrice");
                                                                //  print("+ ${totaladdons}");
                                                                produit
                                                                        .addonquantity =
                                                                    totaladdons *
                                                                        finalPrice;
                                                                produit
                                                                        .PrixProduct =
                                                                    produit
                                                                        .addonquantity!;
                                                                //  print("item ${product.addonquantity }");
                                                                //  print(product.addonquantity);
                                                                produit
                                                                        .addonqtys =
                                                                    addOnQuantity[
                                                                        item.id!];
                                                                produit
                                                                    .addonchoise = [
                                                                  {
                                                                    "name":
                                                                        "${item.name}"
                                                                  },
                                                                  {
                                                                    "price":
                                                                        "${item.price}"
                                                                  }
                                                                ];

                                                            produit.addonname= item.name;

                                                                //product.addonchoise= product.addonchoise!.map((resmap) =>{"name":"${item.name}" , "price" : "${item.price}" });

                                                                // print(product.addonchoise);
                                                                //  product.addonchoise=listaddon;

                                                                // print(product.addonchoise);
                                                                //  print(product.addonchoise.runtimeType);
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 25,
                                                              height: 25,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle),
                                                              child: Icon(
                                                                Icons.add,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                // By default, show a loading spinner.
                                                return SizedBox.shrink();
                                              }
                                            },
                                          ),
                                        ),
                                      //],
                                      //),

                                   

                                      Row(
                                        children: [
                                          // Text((().toString())),
                                          Text("Prix Total : " +
                                              ((calculer()).toString())),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          
                                          ElevatedButton(
                                            onPressed: () {
                                           
                                           addtocart(produit);
                                            
                                            },
                                            child: Text("Ajouter",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                )),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.green.shade400),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                      side: BorderSide(color: Colors.green.shade200)
                                                )
                                                  
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }));
                            });/* .then((value){
                              
                               
})   */
  }
  void refreshData() {
    id++;
  } 
     /* void showProductComposeDialog() {
  showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: 
            ProdDetails(produit: newproduct,),
                    );
        },
      );

      } */
}
