import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/globals.dart';
import 'package:flutter_caissenregistreuse_1/models/categories.dart';
import 'package:flutter_caissenregistreuse_1/models/formules.dart';
import 'package:flutter_caissenregistreuse_1/models/products.dart';
import 'package:flutter_caissenregistreuse_1/models/productsComp.dart';
import 'package:flutter_caissenregistreuse_1/widgets/cart.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/src/provider.dart';

class ProductComp extends StatefulWidget {
  var value ;
    var  random = 4 ;
   
 ProductComp({Key? key}) : super(key: key);

  @override
  State<ProductComp> createState() => _ProductCompState();
}

class _ProductCompState extends State<ProductComp> {
  List<Product> productcomp = [] ;
   List<int> productQuantity = List.filled(10000, 1);
int _counter = 0;
  //List<Formule> form = [];
 //List<String> selectedproduct = [];
 var productchoise = [];
 
            
  var formulechoise ;
  var ImageUrl = "http://khazinav2.tannichm46.sg-host.com/storage/productcompose/";
  @override
  
      void initState(){
    //super.initState();
    if (mounted) {
      _getFormule();
    }
   //selectedproduct = [];


  }

     _getFormule() async {
  
    await _initData();

  }
  _initData() async {
   
       Network().fetchProductComp().then((value) => {
                                
                      if(value.isNotEmpty){
       setState(() {
               productcomp.addAll(value);
      }), }
                              }); }

                               void addtocart(item){

   item.type = "productComposes";
                                            context
                                                  .read<Cart>()
                                                  .addToCart(item);
                                            

      Network().fetchProductComp().then((value) => {
       setState(() {
          productcomp  = value;
        })
        });
 
                                            Navigator.pop(context,true);
  }
                              
  Widget build(BuildContext context) {

    return   Container(
           width: MediaQuery.of(context).size.width * 0.5,
            height:  MediaQuery.of(context).size.height * 0.5,
             child: Wrap(
            //  itemCount: formule.length,
             // shrinkWrap: true,
             // scrollDirection: Axis.vertical,
             // itemBuilder: (context, index)
             children: List.generate(
            productcomp.length, (index) {
              
              final item = productcomp[index];
                            


           item.prix=  item.price!;

                   var Comproducts = jsonDecode(productcomp[index].ingredients!);

  calculer(){
                             
            item.PrixProduct =
            item.price! * item.quantitychoise ;
      return item.PrixProduct!;
                  }  
                   if(item != null) {   
             return Container(
                       //    height: MediaQuery.of(context).size.height * 0.25, 
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: GestureDetector(
                child: Column(
                  children: [
                
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                                          Image.network(
                                            ImageUrl + item.image!,
                                            fit: BoxFit.contain,
                                            width:
                                                MediaQuery.of(context).size.width * 0.1,
                                            height: MediaQuery.of(context).size.height *
                                                0.1,
                                          ),
                  
                   
                                              Text(
                                                item.name!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                           Padding(padding: EdgeInsets.all(3)),
                                             Text(
                                                "${item.price} TND",
                                              )
                  ]
                ),
                                    onTap: () =>{
                                          
                                 
                                                       productQuantity = List.filled(10000, 1),

                            item.quantitychoise =1,                   
                                      showDialog  (
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog ( 
                                              
                                   content: StatefulBuilder (  
                                  builder: (BuildContext , StateSetter setState){
                                    
                                  return  GestureDetector(
                                 onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                                   child: SingleChildScrollView(
                                      child:
                                      Container (
                                                      width: MediaQuery.of(context).size.width*0.3,
                                                          child: Wrap (
                                                            children: [
                                                              Center(
                                                                child: Image.network(
                                                                  ImageUrl +item.image!,
                                                                  fit: BoxFit.contain,
                                                                  width: MediaQuery.of(context)
                                                                          .size
                                                                          .width *
                                                                      0.15,
                                                                  height: MediaQuery.of(context)
                                                                          .size
                                                                          .height *
                                                                      0.15,
                                                                ),
                                                              ),
                                                                    Center(
                                                                      child: Column(children: [
                                                                   Text(
                                                        item.name!,
                                                 style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize: 20),
                                                                  ),
                                                                                                                             
                                                                 Column(children: [
                                                                      Text(
                                                                        "${item.price.toString()} TND",
                                                                      )
                                                                 ])
                                                                      ]),
                                                                    ),
                                                                       /*  Row(
                                                                          children: [
                                                                            Text("Category"),
                                                                          ],
                                                                        ),
                                                                  */
                                                                /*   Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child:  */
                                                                            Column(
                                                                                children: [
                                                                                   for(var i =0;i<Comproducts.length; i++)
                                                                                   Column(
                                                                                       mainAxisAlignment: MainAxisAlignment.start,
                                                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                     
                                                                            Text("Catégorie" , style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, fontSize: 18)),
                                                                                    
                                                                                SizedBox(height:10,),
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(Comproducts[i]['categories'].toString()),
                                                                                        SizedBox(width: 5,),
                                                                                 Text("requis" +Comproducts[i]['requis'].toString(), style: TextStyle(backgroundColor: Colors.blueGrey[100],fontWeight: FontWeight.normal,fontStyle: FontStyle.italic ,fontSize: 13 ,),
                                                                                   ), ],
                                                                                  ),
                                                                              Container(
                                                                                    height:100,
                                                                                    child : ListView(
                                                                                        children: Comproducts[i]['ingredients'].toString().split(',').map((String key) {
                                                                                          return CheckboxListTile(
                                                                                            title: new Text(key),
                                                                                            value: productchoise.firstWhere((element) => element["Category"].contains(Comproducts[i]['categories']),orElse :() => {"ingredients" : []})['ingredients'].contains(key),
                                    
                                                                                            activeColor: Colors.green[200],
                                                                                            checkColor: Colors.white,
                                                                                            onChanged: (bool? value) {
                                                                                        //             if(selectedproduct.contains(key)){
                                                                                        //               selectedproduct.remove(key);
                                                                                                     
                                                                                        //      setState(() {
                                                                                        // _counter--;
                                                                                        //           });
                                                                                        //             } 
                                                                                        //             else 
                                                                                             // selectedproduct.add(key);
                                                                                          //  formulechoise = productchoise;
                                                                                         // print(productchoise);
                                                                                         try {
                                                                                          
                                                                                           if(productchoise.isEmpty){
                                                                                         /*  setState(() {
                                                                                        _counter++;
                                                                                      }); */
                                                                                        // print(key) ;      
                                                                                      productchoise.add({"Category" : "${Comproducts[i]['categories']}" , "requis" : "${Comproducts[i]['requis']}","ingredients" :[key],});
                                                                                    // print(productchoise);
                                                                                    // print('object');
                                                                                           }
                                                                                           else{
                                                                                        //    print( Comproducts[i]['categories']);
                                                                                    var  selecteddprodcutCopy = productchoise.firstWhere((element) => element["Category"] == Comproducts[i]['categories'], orElse :() => "null");
                                                                                   
                                                                                    if(selecteddprodcutCopy != "null"  ) {
                                                                                             // print(selecteddprodcutCopy);
                                                                            
                                                                                      if (productchoise.firstWhere((element) => element["Category"] == Comproducts[i]['categories'], orElse :() => {"ingredients" : []})['ingredients'].contains(key)){
                                                                                    productchoise = productchoise.map((c) =>   c["Category"] == Comproducts[i]['categories'] ? {
                                                                                      
                                                                                      "Category" : c["Category"],
                                                                                      "ingredients" : [...c["ingredients"]].where((element) => element != key).toList(),
                                                                                    "requis" :c["requis"] 
                                                                                    } : c).toList();
                                                                                      }else {
                                                                                    var count = selecteddprodcutCopy["ingredients"].length;
                                                                                      if(count < int.parse(Comproducts[i]['requis'])){
                                                                                    productchoise = productchoise.map((c) =>   c["Category"] == Comproducts[i]['categories'] ? {
                                                                                      
                                                                                      "Category" : c["Category"],
                                                                                      "ingredients" : [...c["ingredients"],key],
                                                                                    "requis" :c["requis"] 
                                                                                    } : c).toList();
                                                                                       
                                                                                      
                                                                                      }
                                                                                   // print(key);
                                                                                   // print(productchoise); 
                                                                                    
                                                                                    /* else {
                                                                                      print(selecteddprodcutCopy);
                                                                                    } */
                                                                                      }
                                                                                       
                                    
                                                                                         }
                                                                                         else {
                                                                                           print("rr");
                                                                                            productchoise.add({"Category" : "${Comproducts[i]['categories']}" , "requis" : "${Comproducts[i]['requis']}","ingredients" :[key]});
                                                                                         }
                                                                                         }
                                                                                           item.selectedingredient = productchoise.toString();
                                                                                        }
                                                                                       on Exception catch (_) {
                                                                                    print('never reached');
                                                                                  }
                                                                                    
                                                                                           setState(() {
                                                                                        _counter++;
                                                                                      }); 
                                                                                            
                                                                                      //productchoise = [{"Category" : "${Comproducts[i]['categories']}" , "requis" : "${Comproducts[i]['requis']}","products" :"$selectedproduct",}];
                                                                                      // print(productchoise);
                                                                                           
                                                                                             // formulechoise = [{"requisCategory" : "$_counter" , "products" : "$productchoise"}];
                                                                                          // formulechoise = List.from(productchoise);
                                                                                          // formulechoise = productchoise.map((v) => v).toList();
                                                                                    
                                                                                            //print(formulechoise);
                                                                                                  /*    if(){
                                                                                    
                                                                                               }     
                                                                                     */
                                                                                         
                                                                                       
                                                                                        
                                                                                          
                                                                                            },
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    
                                                                                 ), 
                                                                                 
                                                                                 /* 
                                                                                  CheckboxGroup(
                                                                                     
                                                                                orientation: GroupedButtonsOrientation.HORIZONTAL,
                                                                                margin: const EdgeInsets.only(left: 12.0),
                                                                                /*onSelected: (List selected) => setState(() {
                                                                                  Comproducts['product']= selected;
                                                                                }),*/
                                                                                labels:
                                                                                   <String>[ Comproducts[i]['products']],
                                                                                 
                                                                              onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
                                                                              onSelected:  (checked) {
                                                                                (){  };
                                                                              }, 
                                                                            
                                                                                   ) */
                                                                                     
                                                                               
                                                                                /*       Container(
                                                                                          width: MediaQuery.of(context).size.width ,
                                                                                            child:  ToggleButtons(
                                                                                    
                                                                                          isSelected: isSelected,
                                                                                            selectedColor: Colors.white,
                                                                                            color: Colors.black,
                                                                                            fillColor: Colors.lightBlue.shade900,
                                                                                            renderBorder: false,
                                                                                            highlightColor: Colors.orange,
                                                                                            children:  <Widget>[
                                                                                          // for(var i =0;i<Comproducts.length; i++)
                                                                               
                                                                                              Padding(
                                                                                                
                                                                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                                                                   child: Text(Comproducts[i]['products'], style: TextStyle(fontSize: 18)),
                                                                                                   
                                                                                              ),
                                                                                            ],
                                                                                            onPressed: (int newIndex) {
                                                                                              setState(() {
                                                                               
                                                                                       for (int index = 0; index < isSelected.length; index++) {
                                                                                                  if (index == newIndex) {
                                                                                                    isSelected[index] = true;
                                                                                                 
                                                                                                  // print(product.sizechoise);
                                                                                                  } else {
                                                                                                    isSelected[index] = false;
                                                                                                  }
                                                                                                }
                                                                               
                                                                                      
                                                                                              });
                                                                                            },
                                                                                          
                                                                                     ),
                                                                                          
                                                                                          /* CheckboxListTile(
                                                                                              title: Text(Comproducts[i]['products'].toString()),
                                                                                              autofocus: false,
                                                                                              activeColor: Colors.green,
                                                                                              checkColor: Colors.white,
                                                                                             selected: _value,
                                                                                              value: _value,
                                                                                              onChanged: (value)onClicked() {
                                                                             setState(() {  
                                                                                        final newValue = !Comproducts[i]['products'].value;
                                                                                       Comproducts[i]['products'].value = newValue;
                                                                            
                                                                                     
                                                                                      });
                                                                                      };
                                                                                      } 
                                                                                            ),*/
                                                                                        ), */
                                                                                  
                                                                                        
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            
                                                                //  ),
                                                         
                                    
                                                               
                                                                 
                                                          
                                                        Row( 
                                                          children: [
                                                       Padding(
                                                         padding: const EdgeInsets.only(bottom : 8.0),
                                                         child: Container(
                                                           width: MediaQuery.of(context).size.width * 0.3,
                                                           child: const TextField(
                                                              decoration: InputDecoration(labelText: 'Commentaire'),
                                      keyboardType: TextInputType.multiline,
                                        textInputAction: TextInputAction.newline,
                                        minLines: 1,
                                        maxLines: 5,
                                         ),
                                                         ),
                                                       )
                                                          ],
                                                        ),
                                        Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                        
                                                                children: [
                                                                
                                                                  Text("Quantité",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold)),
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
                                                                           productQuantity[item.id!]--;
                                                                           
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
                                       
                                                                               if(productQuantity[item.id!]<1)
                                                                                       { 
                                                                                          productQuantity[item.id!] = 1;
                                                                                       
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                       //product.price
                                                                                      /*  finalPrice= productQuantity[
                                                                                      product.id!] * Prixproduct!; */
                                                                                        //  print(finalPrice);
                                                                                         // PrixTotal = finalPrice;
                                                                                       } 
                                                                                    item.quantitychoise = productQuantity[item.id!];
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
                                                                        productQuantity[item.id!].toString(),style: TextStyle(fontSize: 16), ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            //Changed here
                                                                            productQuantity[
                                                                               item
                                                                                    .id!]++;
                                                                           
                                                                                       //product.price
                                                                                     /*  finalPrice  = productQuantity[
                                                                                      product.id!] * Prixproduct!; */
                                                                                        
                                                                                    item.quantitychoise = productQuantity[item.id!];
                                                                                      // print(product.quantitychoise); 
                                                                                       
                                                                                 
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
                                                                    
                                                              Row(
                                                                
                                                                children: [
                                                                    
                                                             // Text((().toString())),
                                                              Text("Prix Total : " + ((calculer()).toStringAsFixed(2) .toString())),
                                                                ],
                                                                                    
                                                              ),
                                    
                                                                     Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.end,
                                                                children: [
                                                                  ElevatedButton(
                                                                    onPressed: () {  
                                                                      //Navigator.pop(context);   
                                                                
                                    
                                                                      if(item.selectedingredient!.isNotEmpty)
                                                                 {
                                                                 addtocart(item);
                                                                 }
                                    
                                                                 else {
                                                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text("vous devez sélectionner ingredient"),
                                                           )); 
                                                                 }
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
                                                              ]
                                                              )
                                                              ),
                                   ),
                                  );
                                                          }
                                                          )
                                                          );
                                                          }
                                                          ).then((value){
  setState(() {
    productchoise = [];
  
  }); 
}) 


                                    },
                                  )
                              )
                              
             );
             
                
       }
       else return SizedBox.shrink();
              }
             // else  return SizedBox.shrink();
             // }
              
             )
       
             ) 
     );
            }
           
  }

