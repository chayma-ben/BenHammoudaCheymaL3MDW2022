import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/models/order.dart';
import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;
import 'package:flutter_caissenregistreuse_1/screens/home.dart';

class Revenus extends StatefulWidget {
  Revenus({Key? key}) : super(key: key);

  @override
  State<Revenus> createState() => _RevenusState();
}

class _RevenusState extends State<Revenus> {
  List<Order> listeorder = [];
  void initState() {
    if(mounted){
    Network().fetchOrder().then((value) => {
          if (value.isNotEmpty)
            {
              setState(() {
                listeorder.addAll(value);
              }),
            }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
           
    calculrevenus() { 
      var listpaid =listeorder.where((element) => element.paymentStatus == "paid"  && element.branchId == globals.branchid );
      return listpaid.fold(0.0, (double currentTotal, Order item) {
        return (currentTotal + item.orderAmount!);
      });
    }

    calculUnpaid() {
      
      var listpaid = listeorder.where((element) => element.paymentStatus == "unpaid" && element.branchId == globals.branchid );

      return listpaid.fold(0.0, (double currentTotal, Order item) {
        return (currentTotal + item.orderAmount!);
      });
    } 

   /*  totalorder(){
    var listpaid = listeorder.where((element) => element.branchId == globals.branchid );
return listpaid.length;
    }  */
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart_rounded, size: 30),
              Text(
                "Statistique des commandes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xffB4D9CB),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(Icons.add_shopping_cart_sharp, size: 30),
                        title: Text(
                          'Toutes les commandes',
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(globals.orderlistlength.toString(),
                              style: TextStyle(fontSize: 20))),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xffF8C57C),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(Icons.money, size: 30),
                        title: Text(
                          'Revenus',
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                              '${calculrevenus()}' +
                                  '${globals.restaucurrency}',
                              style: TextStyle(fontSize: 20))),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xffF2F2F2),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(Icons.money_off_sharp, size: 30),
                        title: Text(
                          'Commandes non payées',
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                              '${calculUnpaid()}' + '${globals.restaucurrency}',
                              style: TextStyle(fontSize: 20))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
