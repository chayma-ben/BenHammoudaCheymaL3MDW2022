import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/models/table.dart';
 import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;

class Tables extends StatefulWidget {
  Tables({Key? key}) : super(key: key);

  @override
  State<Tables> createState() => _TablesState();

}

class _TablesState extends State<Tables> {

   List<TableModel> listetable = [];

   void initState(){
    super.initState();
    if(mounted){
 Network().fetchTable().then((value) => {
                              
                              //  print(value),
                                if(value.isNotEmpty){
                              setState(() {
                                  listetable.addAll(value);

      }),  
 }
    

                              });
    }

  }
  bool selectedDay = true;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,

       child :  Wrap(
                  children: List.generate(
                    listetable.length,
                    (index) { 
                      final table = listetable[index];
                              return Container(
                            height: MediaQuery.of(context).size.height * 0.25, 
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: GestureDetector(
                                      child: Visibility(
                                        visible: selectedDay,
                                        child: Column(
                                          children: [
                                          
                                            Padding(padding: EdgeInsets.only(bottom: 20)),
                                          Image.asset(
                                              "images/table.jpg",
                                              fit: BoxFit.contain,
                                              width:
                                                  MediaQuery.of(context).size.width * 0.1,
                                              height: MediaQuery.of(context).size.height *
                                                  0.1,
                                            ),   
                                            
                                                Text(
                                                 "Table " +table.num.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ), 
                                      
                                      
                                                  RaisedButton(
                                                            onPressed: () {
                                                             //Network().postData();
                                            globals.status = "confirmed";
                                                        Network().cart();
                                                                    },
                                                            child: Text("Valider"),
                                                            color: Colors.amber,
                                                          ),   
                                      
                                                             RaisedButton(
                                                            onPressed: () {
                                                                 setState(() {
                                                                   selectedDay = false;
                                                                
                                                                 });                            
                                                                    },
                                                            child: Text("escd"),
                                                            color: Colors.amber,
                                                          ),
                                                
                                          /*   Padding(padding: EdgeInsets.all(3)),
                                            if (product.discount! > 0)
                                              Column(children: [
                                                Text(
                                                  "${product.price.toString()} TND",
                                                  style: new TextStyle(
                                                    color: Colors.grey,
                                                    decoration:
                                                        TextDecoration.lineThrough,
                                                  ),
                                                ),
                                                Text(
                                                  "${product.price} TND",
                                                )
                                              ])
                                            else
                                              Text(
                                                "${product.price.toString()} TND",
                                              ),
                                          */
                                               
                                                          
                                          ],
                                        ),
                                      ), 
                                  )
                              )
                              );  
                    }
                  )
       )
    );
  }
}