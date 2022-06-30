import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/models/categories.dart';
import '../api/api.dart';
 import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;



class CategoryWidget extends StatefulWidget {
  final Function(int) OnTap;
  CategoryWidget({Key? key, required this.OnTap}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
var  formule;
List<Category> CategoryListe =[];
var categoryForDisplay = <Category>[];
  List<bool> _selected = List.generate(200, (i) => false); // Pre filled list
  int? selectedIndex;

  var ImageUrl ="http://khazinav2.tannichm46.sg-host.com/storage/category/";

  @override
    void initState(){
   // super.initState();
   if (mounted) {
      _getCategories();
   }

  }


   _getCategories() async {
  
    await _initData();

  }
  _initData() async {
   Network().fetchCategory().then((value) => {
                              
                              //  print(value),
                                if(value.isNotEmpty){
                              setState(() {
                                  CategoryListe.addAll(value);

      }),  
 }
    

                              });


  }

 
    Widget build(BuildContext context) {
    //print(widget.values);        
               return Scrollbar(
                  child:
                         ListView.builder(
                           itemCount: CategoryListe.length,
                               shrinkWrap: true,
                               scrollDirection: Axis.horizontal,
                               // Provide a builder function. This is where the magic happens.
                               // Convert each item into a widget based on the type of item it is.
                               itemBuilder: (context, index)
                               {    
                                  //final _isSelected=_selectedIndexs.contains(index);
                                 var   category = CategoryListe[index];
                                   
                                List<bool> isClicked = List.filled(CategoryListe.length, false);
                                     //globals.a = CategoryListe[index].id!;
                                    //print(globals.a.runtimeType);
                           if(category != null) {
                                     return Padding(
                                     padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          left: 15,
                                     ),
                                     child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                               widget.OnTap(category.id!);
                                
                                setState(() {
                                  selectedIndex = index; 

                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                color: selectedIndex == index ?  Color(0xffec1c24) : Colors.transparent,
                                       ),
                                  color: Color(0xffFAFCFE),
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      ImageUrl + category.image!,
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width * 0.04,
                                      height:
                                          MediaQuery.of(context).size.height * 0.04,
                                    ),
                                    Center(
                                      child: Text(category.name!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15)),
                                    ),
                                  ],
                                ),
                              ),
                              
                            ),
                           
                          ],
                                     ),
                                   );
                           
                                   
                                   }
                                   else return SizedBox();
                               }
                                     ), 
                   
                  
                      
           
             );
  }


} 




      