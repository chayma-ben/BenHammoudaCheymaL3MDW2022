import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/models/order.dart';
import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;
import 'package:flutter_caissenregistreuse_1/models/table.dart';

class OrderWid extends StatefulWidget {
  OrderWid({Key? key}) : super(key: key);

  @override
  State<OrderWid> createState() => _OrderState();



  

}

class _OrderState extends State<OrderWid> {
   List<Order> listeorder = [];

  String pressedepalce = "Sur place";
String selectedOrder = "Sur place";

  String selectedPayement = "Espèce";

  void initState(){
   if(mounted){
  Network().fetchOrder().then((value) => {
      if(value.isNotEmpty){
       setState(() {
   listeorder.addAll(value);
      }),  
 }
 });
   }

  }
  @override
  Widget build(BuildContext context) {
    return Container( width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,

       child :  Wrap(
                  children: List.generate(
                    listeorder.length,
                    (index) {
                      var order = listeorder[index];
                       return SingleChildScrollView(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        //  height: MediaQuery.of(context).size.height,
 
                        child: Column(
                          children: [
                            Row(
       crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
                              children: [  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonTheme(
                //minWidth: 100.0,
                height: 90.0,
                buttonColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: RaisedButton(
                  onPressed: () {
                    globals.order_type = "Livraison";
                    setState(() {
                      selectedOrder = "Livraison";
                    });
                  },
                  child: Column(children: [
                    Icon(
                      Icons.delivery_dining_outlined,
                      color: selectedOrder == "Livraison"
                          ? Colors.white
                          : Colors.black,
                    ),
                    Text("Livraison",
                        style: TextStyle(
                          color: selectedOrder == "Livraison"
                              ? Colors.white
                              : Colors.black,
                        )),
                  ]),
                  color: selectedOrder == "Livraison"
                      ? Color(0xffec1c24)
                      : Colors.white,
                ),
              ),
              // Padding(padding: EdgeInsets.fromLTRB(5, 10, 0, 0)),
              ButtonTheme(
                //minWidth: 100.0,
                height: 90.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                buttonColor: Colors.blueGrey,

                child: RaisedButton(
                  onPressed: () {
                    globals.order_type = "Emporter";
                    setState(() {
                      selectedOrder = "Emporter";
                    });
                  },
                  child: Column(
                    children: [
                      Icon(Icons.shopping_bag_outlined,
                          color: selectedOrder == "Emporter"
                              ? Colors.white
                              : Colors.black),
                      Text("Emporter",
                          style: TextStyle(
                            color: selectedOrder == "Emporter"
                                ? Colors.white
                                : Colors.black,
                          )),
                    ],
                  ),
                  color: selectedOrder == "Emporter"
                      ? Color(0xffec1c24)
                      : Colors.white,
                ),
              ),
              ButtonTheme(
                height: 90.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                buttonColor: Colors.white,
                child: RaisedButton(
                  onPressed: () {
                   
                    globals.order_type = "Sur_Place";
                    setState(() {
                      selectedOrder = "Sur_Place";
                    });
                  },
                  child: Column(
                    children: [
                      Icon(Icons.food_bank_outlined,
                          color: selectedOrder == "Sur_Place"
                              ? Colors.white
                              : Colors.black),
                      Text("Sur place",
                          style: TextStyle(
                            color: selectedOrder == "Sur_Place"
                                ? Colors.white
                                : Colors.black,
                          )),
                    ],
                  ),
                  color: selectedOrder == "Sur_Place"
                      ? Color(0xffec1c24)
                      : Colors.white,
                ),
              ),
            ],
          ),
       ],),
                            
                                Wrap(
                                    children: List.generate(listeorder.length, (index) {
                                  final order = listeorder[index];
                                  // globals.orderid = listeorder;
                                                         gettableNum (){
            /*  for (TableModel T in listetable){
        if( T.id == order.tableId){
            return T.num;
        }
    } */
} 
                                if(order.orderType == selectedOrder && order.branchId == globals.branchid){
        
                                  return Container(
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    width: MediaQuery.of(context).size.width * 0.15,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      color: Color(0xffFFFFF0),
                                      elevation: 10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Ticket #" + order.id.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          if (order.tableId != null)
                                            Text(
                                              "Table" + gettableNum().toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            order.paymentStatus.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                                               "Total "+ order.orderAmount.toString() + globals.restaucurrency,
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15),
                                                            ), 

                                          /*  Text(
                                                             order.createdAt.toString(),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15),
                                                            ),
                                                             Text(
                                                             order.updatedAt.toString(),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15),
                                                            ), */
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else return  SizedBox();
                                 
                                                           
                                                                   
                              })),
                              ],
                            ),
                          
                        ));

                    } )
    )
    /*  */);
  }
}