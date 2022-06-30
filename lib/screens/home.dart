import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/models/order.dart';
import 'package:flutter_caissenregistreuse_1/models/restaurant.dart';
import 'package:flutter_caissenregistreuse_1/models/table.dart';
import 'package:flutter_caissenregistreuse_1/widgets/cart.dart';
import 'package:flutter_caissenregistreuse_1/widgets/formule.dart';
import 'package:flutter_caissenregistreuse_1/widgets/popUp/revenus.dart';
import 'package:flutter_caissenregistreuse_1/widgets/product1.dart';
import 'package:flutter_caissenregistreuse_1/widgets/productComp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/popUp/calculatrice.dart';
import 'package:intl/intl.dart';
import 'package:flutter_caissenregistreuse_1/screens/logout.dart';
import '../widgets/Category.dart';
import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

/*   static final DateTime now = DateTime.now().toLocal();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
 */
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamController _controller = StreamController();

  late String _timeString;


  var name;
  var idbranch;
  var valueFilter = 0;
  var values = 5;

  String pressedepalce = "Sur place";
String selectedOrder = "Sur place";

  String selectedPayement = "Espèce";


  var urlimage = "http://khazinav2.tannichm46.sg-host.com/storage/restaurant/";

//List<Product> products = [];
  List<TableModel> listetable = [];
  bool selectedTable = true;

  List<Order> listeorder = [];
  Restaurant? restau;

//List<Product> products = products;
  void initState() {
    if (mounted) {
    _loadUserData();
    }
    
   _timeString = _formatDateTime(DateTime.now());
   Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
 

    Network().fetchRestaurant().then((value) => {
          setState(() {
            restau = value;
          }),
        });
    Network().fetchTable().then((value) => {
          //  print(value),
          if (value.isNotEmpty)
            { 
               if (mounted) { 
              setState(() {
                listetable.addAll(value);
              }),
               }
            }
        });

           Network().fetchOrder().then((value) => {
          if (value.isNotEmpty)
            { 
              if (mounted) { 
              setState(() {
                listeorder.addAll(value);
              }),
              }
            }
        });
  }
  


  _loadUserData() async {
    //SharedPreferences localStorage = await SharedPreferences.getInstance();
  //  var user = jsonDecode(localStorage.getString('branch')!);
    SharedPreferences localStorage = await SharedPreferences.getInstance();

 String user = localStorage.getString('branch') ?? "";
  if (user != "") {
  
  var branch = json.decode(user);  
      setState(() {
        name = branch[0]['name'];
        idbranch=branch[0]['id'];
        globals.branchid = idbranch;
      });
    }
    else  setState(() {
        name = "Caissier";
      });
  }

   

     totalorder(){
    var listpaid = listeorder.where((element) => element.branchId == globals.branchid );
    globals.orderlistlength =listpaid.length;
return listpaid.length;
    }

 

  @override
  Widget build(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height * 0.15;
    final profileHeight = MediaQuery.of(context).size.height * 0.1;
    final pos = containerHeight - profileHeight / 15;
    // return RefreshIndicator(
    // onRefresh: getDataref,
    // child:
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffF1F7FC),
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              _topBar(),
              _body(),
              // Positioned(top: pos, left: 50, child: _profilePic()),
            ],
          )),
      //  ),
    );
  }

  /************************************************************************    Widgets    ************************************************************************** */
  Widget _restauInfo() {
    if (restau != null) {
      globals.restaucurrency = restau!.currencySymbol!;
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.network(
          urlimage + restau!.restaurantLogo!,
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Text(restau!.restaurantName!),


            Text(_timeString),

       Text(
              "Salut, ${name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
      ]);
    } else
      return SizedBox();
  }
 

  Widget _topBar() {
    final containerHeight = MediaQuery.of(context).size.height * 0.1;
    return Container(
      color: Colors.white,
      height: containerHeight,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: _restauInfo(),
          ),
          // Expanded(child: ListView.builder(itemBuilder: )),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Home()),
                       
                        );
                    setState(() {
                      context.read<Cart>().removeCart();
                    });

                    // Cart().removeCart();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                child: Logout(),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Text(
              "Total ${globals.product}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            /*   Text(
            "Order ",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),*/
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.14,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _commande(),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.14,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _containerLshape(),
            _containerLshape1(),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.32,
          left: MediaQuery.of(context).size.width * 0.12,
        ),
        /* decoration: BoxDecoration(
            //color: Colors.white, 
          borderRadius: BorderRadius.circular(80)),*/
        width: MediaQuery.of(context).size.width * 0.62,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            children: [
              Product1(values: valueFilter),
            ],
          ),
        ),

        //values: valueFilter
        //values: valueFilter
      )
    ]);
  }

  Widget _commande() {
    return Stack(children: [
      Container(
        margin: new EdgeInsets.fromLTRB(0, 0, 5, 0),
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 10)),
                  Text("Commande #${totalorder()}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
               
                ]),
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.001,
                color: Colors.grey[400],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      pressedepalce = "Livraison";
                    });
                  },
                  child: Column(children: [
                    Icon(
                      Icons.delivery_dining_outlined,
                      color: pressedepalce == "Livraison"
                          ? Colors.white
                          : Colors.black,
                    ),
                    Text("Livraison",
                        style: TextStyle(
                          color: pressedepalce == "Livraison"
                              ? Colors.white
                              : Colors.black,
                        )),
                  ]),
                  color: pressedepalce == "Livraison"
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
                      pressedepalce = "Emporter";
                    });
                  },
                  child: Column(
                    children: [
                      Icon(Icons.shopping_bag_outlined,
                          color: pressedepalce == "Emporter"
                              ? Colors.white
                              : Colors.black),
                      Text("Emporter",
                          style: TextStyle(
                            color: pressedepalce == "Emporter"
                                ? Colors.white
                                : Colors.black,
                          )),
                    ],
                  ),
                  color: pressedepalce == "Emporter"
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
                    showTablesDialog();
                    globals.order_type = "Sur_Place";
                    setState(() {
                      pressedepalce = "Sur_Place";
                    });
                  },
                  child: Column(
                    children: [
                      Icon(Icons.food_bank_outlined,
                          color: pressedepalce == "Sur_Place"
                              ? Colors.white
                              : Colors.black),
                      Text("Sur place",
                          style: TextStyle(
                            color: pressedepalce == "Sur_Place"
                                ? Colors.white
                                : Colors.black,
                          )),
                    ],
                  ),
                  color: pressedepalce == "Sur_Place"
                      ? Color(0xffec1c24)
                      : Colors.white,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 5,
              bottom: 10,
            ),
            width: MediaQuery.of(context).size.width * 0.24,
            height: MediaQuery.of(context).size.height * 0.45,
            color: Color(0xffF1F7FC),
            child:
                // Text("cart"),
                //
                CartPage(),
          ),

          /*  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: MediaQuery.of(context).size.height * 0.001,
                      color: Colors.black),
                ],
              ),
              Row(
                children: [
                  Padding(padding: const EdgeInsets.only(left: 10)),
                  Text(
                    "Total",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                  Spacer(),
                  Text("0.00")
                ],
              ) , */

          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                margin: EdgeInsets.only(
                  top: 5,
                ),
                height: MediaQuery.of(context).size.height * 0.005,
                color: Color(0xffF1F7FC),
              )
            ],
          ),
          Row(children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 5,
              ),
              padding: const EdgeInsets.only(left: 10),
              child: Text("Moyen de paiement",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonTheme(
                // minWidth: 100.0,
                height: 80,
                buttonColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: RaisedButton(
                  onPressed: () {
                    showCalculDialog();
                    globals.payment_method = "espèce";
                    print(globals.payment_method);
                    setState(() {
                      selectedPayement = "Espèce";
                    });
                  },
                  child: Column(children: [
                    Icon(
                      Icons.monetization_on,
                      color:  selectedPayement == "Espèce" ? Colors.white : Colors.black,
                    ),
                    Text("Espèce",
                        style: TextStyle(
                          color: selectedPayement == "Espèce" ? Colors.white : Colors.black,
                        )),
                  ]),
                  color: selectedPayement == "Espèce" ? Color(0xffec1c24) : Colors.white,
                ),
              ),
              ButtonTheme(
                //minWidth: 100.0,
                height: 80,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                // buttonColor:  Colors.blue,
                child: RaisedButton(
                  onPressed: () {
                    globals.payment_method = "Carte-bancaire";
                    print(globals.payment_method);

                    setState(() {
                      selectedPayement = "Carte-bancaire";
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: selectedPayement == "Carte-bancaire" ? Colors.white : Colors.black,
                      ),
                      Text("Carte \n Bancaire",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedPayement == "Carte-bancaire" ? Colors.white : Colors.black,
                          )),
                    ],
                  ),
                  color: selectedPayement == "Carte-bancaire" ? Color(0xffec1c24) : Colors.white,
                ),
              ),

              // _buildButton(Colors.white, "Carte Bancaire"),
              // _buildButton(Colors.white, ""),
            ],
          ),

          /* Row(
            children: [],
          ),*/

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   RaisedButton(
                      onPressed: () {
                        globals.status = "canceled";
                        Network().cart();
                        setState(() {
                          context.read<Cart>().removeCart();
                        });
                      },
                      child: Text("Annuler"),
                      color: Color(0xffec1c24),
                    ),
                    RaisedButton(
                      onPressed: () {
                        globals.status = "pending";
                        Network().cart();
                      },
                      child: Text("En attente"),
                      color: Colors.orange[400],
                    ),
                   
                      RaisedButton(
                      onPressed: () {
                        globals.status = "confirmed";

                        Network().cart();
                        setState(() {
                          context.read<Cart>().removeCart();
                        });
                        pressedepalce = "Sur place";
                       selectedPayement = "Espèce";
                      
                        /*   globals.payment_method= "";  
                           globals.order_type = "";
                  }*/
                      },
                      child: Text("Valider"),
                      color: Colors.green[400],
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    ]);
  }

  Widget _containerLshape() {
    return Container(
      child: Container(
          margin: new EdgeInsets.fromLTRB(10, 0, 0, 0),
          height: MediaQuery.of(context).size.height * 0.85,
          width: MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(17)),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              _itemLeft(),
            ],
          )),
    );
  }

  Widget _containerLshape1() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.62,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(17),
              bottomRight: Radius.circular(17),
            )),
        child: Stack(children: [
          Column(children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*   Text(
                            "Toutes les Catégories",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),  */

                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      printdd(0);
                    },
                    child: Text(
                      'Toutes les Catégories',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  )
                  /*GestureDetector(
                              onTap: () {
                  
                                
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.amber,
                                ),
                                child: Row(
                                  children: [*/

                  //    FormuleButton(OnTap: printAA,),
                  //  ],
                  // ),
                  //  ),

                  // ),
                ],
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.only(top: 22),
            // height: MediaQuery.of(context).size.height*0.5,
            // color: Colors.amber,
            child: CategoryWidget(
              OnTap: printdd,
            ),
          )

          /*selectedCategoryIndex:CategoryIndex( 
   
      }
  );), ,OnTap: setState(() {
                  selectedCategoryIndex = index;
                }),*/
          //  ),
          // data: categories[index],
          //isSelected: index == selectedCategoryIndex,
          // CategoryWidget(OnTap: printdd)),
        ]));
  }

  Widget _listProduit() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.01,
      //color: Colors.amber,
    );
  }

  /* Widget _categoriesItem() {
    return SingleChildScrollView(
      child: Row(
        children: [
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              //physics: NeverS,
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                           Text(_categories[index].name!),
                          ],
                        ),
                      ),
                    ]));
              },
            ),
          )
        ],
      ),
    );
  }*/

  Widget _itemLeft() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.14
        ),
        Container(
          //  margin: EdgeInsets.only(top: 110),
          child: ButtonTheme(
            minWidth: 100.0,
            height: 80.0,
            buttonColor: Color(0xffF1F7FC),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {
                showTablesDialog();
              },
              child: Column(children: [
                Icon(Icons.restaurant_rounded /*color: Colors.grey[400],*/
                    ),
                Text(
                  "Tables", /*style: TextStyle(color: Colors.grey[400]),*/
                ),
              ]),
            ),
          ),
        ),
        /*  Container(
          margin: EdgeInsets.only(
            top: 30,
          ),
          child: ButtonTheme(
            minWidth: 100.0,
            height: 80.0,
            buttonColor: Color(0xffF1F7FC),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {
                showClientsDialog();
              },
              child: Column(children: [
                Icon(Icons.people_outline),
                Text("Clients"),
                //color: Colors.white,
              ]),
            ),
          ),
        ), */
        /*  SizedBox(
                 height: MediaQuery.of(context).size.height * 0.2,
        ),*/
        Container(
            margin: const EdgeInsets.only(
              top: 25,
            ),
            child: ButtonTheme(
              minWidth: 100.0,
              height: 80.0,
              buttonColor: Color(0xffF1F7FC),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: RaisedButton(
                onPressed: () {
                  
                  showTicketDialog();
                },
                child: Column(children: const [
                  //  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  Icon(
                    Icons.receipt_long_sharp, /*color: Colors.grey[400],*/
                  ),
                  Text(
                    "Tickets", /*style: TextStyle(color: Colors.grey[400]),*/
                  ),
                  //color: Colors.white,
                ]),
              ),
            )),
        /*  Container(
          margin: EdgeInsets.only(
            top: 30,
          ),
          child: ButtonTheme(
            minWidth: 100.0,
            height: 80.0,
            buttonColor: Color(0xffF1F7FC),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {
                _refresh();
              },
              child: Column(children: [
                Icon(Icons.check_circle_outline_rounded),
                Text("Clôture"),
                //color: Colors.white,
              ]),
            ),
          ),
        ),  */
        Container(
          margin: EdgeInsets.only(
            top: 25,
          ),
          child: ButtonTheme(
            minWidth: 100.0,
            height: 80.0,
            buttonColor: Color(0xffF1F7FC),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {
                showFormulesDialog();
              },
              child: Column(children: [
                Icon(Icons.fastfood_outlined),
                Text("Formule"),
                //color: Colors.white,
              ]),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 25,
          ),
          child: ButtonTheme(
            minWidth: 100.0,
            height: 80.0,
            buttonColor: Color(0xffF1F7FC),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {
                showProductComposeDialog();
              },
              child: Column(children: [
                Icon(Icons.fastfood_sharp),
                Text(" Produit \n Composé"),
                //color: Colors.white,
              ]),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 25,
          ),
          child: ButtonTheme(
            minWidth: 100.0,
            height: 80.0,
            buttonColor: Color(0xffF1F7FC),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {
                showRevenusDialog();
              },
              child: Column(children: [
                Icon(Icons.attach_money_outlined),
                Text("Revenus"),
                //color: Colors.white,
              ]),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        if (restau != null)
          Image.network(
            urlimage + restau!.restaurantLogo!,
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height * 0.06,
          ),
      ],
    );
  }

  Widget _profilePic() {
    final profileHeight = MediaQuery.of(context).size.height * 0.1;

    return CircleAvatar(
      radius: profileHeight / 2.8,
      backgroundImage: AssetImage("images/pizza.png"),
    );
  }

  void showCalculDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Calculatrice(),
        );
      },
    );
  }

 

  void showFormulesDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: FormuleWidget(),
        );
      },
    );
  }

  void showProductComposeDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: ProductComp(),
        );
      },
    );
  }

  printdd(valuefilter) {
    //contains:equals
    // print(valuefilter);
    setState(() {
      valueFilter = valuefilter;
    });
    //valueFilter = valuefilter;
  }

  printAA(value) {
    setState(() {
      values = value;
      print("object");
    });
  }

  void showTablesDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              content: StatefulBuilder(
                builder: (BuildContext, StateSetter setState) {
                  return SingleChildScrollView(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height,
                        child: Wrap(
                            children: List.generate(listetable.length, (index) {
                          final table = listetable[index];

                          void editCart() async {
                            var id = table.id;
                            var data = {
                              "table_id": id,
                              "payment_status": "paid",
                            };
                            var res = await Network()
                                .postData(data, '/order/payment');
                          }

                          void ediTable() async {
                            var id = table.id;
                            var data = {
                              "id": id,
                              "status": table.status,
                            };
                            var res =
                                await Network().postData(data, '/table/status');
                          }
                          /* list =  listeorder.where((e) => e.tableId == table.id).toList();
                                         listeaa = list.where((e) => e.paymentStatus == "unpaid"); */


                          return Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: table.status == 1 ? Colors.green : Colors.red ),
                                  ),
                                  child: GestureDetector(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (table.status != 0)
                                            Visibility(
                                              visible: table.selectedTable,
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "images/table.jpg",
                                                    fit: BoxFit.contain,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                  ),
                                                  Text(
                                                    "Table " +
                                                        table.num.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  RaisedButton(
                                                    onPressed: () {
                                                      globals.order_type =
                                                          "Sur_Place";
                                                      globals.idtable =table.id;
                                                          table.status = 0;
                                                         
                                                          "Sur_Place";
                                                      setState(() {
                                                        table.selectedTable =
                                                            false;
                                                        // selectedTable = false;

                                                        
                                                      });
                                                      ediTable();
                                                    },
                                                    child: Text("Valider"),
                                                    color: Colors.green[400],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ButtonTheme(
                                                // minWidth: 100.0,
                                                height: 20,
                                                buttonColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    showCalculDialog();

                                                    globals.payment_method =
                                                        "espèce";
                                                    setState(() {
                                                      table.selectedTable =
                                                          true;
                                                    });
                                                    editCart();

                                                    table.status = 1;
                                                    ediTable();
                                                  },
                                                  child: Icon(
                                                      Icons.monetization_on),

                                                  //color: Colors.white,
                                                ),
                                              ),
                                              ButtonTheme(
                                                //minWidth: 100.0,
                                                height: 20,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                buttonColor: Colors.white,
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    globals.payment_method =
                                                        "Carte-bancaire";
                                                    setState(() {
                                                      table.selectedTable =
                                                          true;
                                                    });
                                                    globals.status =
                                                        "confirmed";
                                                  
                                                    editCart();
                                                    table.status = 1;
                                                    ediTable();
                                                  },
                                                  child:
                                                      Icon(Icons.credit_card),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          /*   RaisedButton(
                                                                onPressed: () { 
                                                                  //   globals.order_type ="Sur_Place";
                                                                  // globals.idtable =table.id;
                                                                     setState(() {
                                                                         table.selectedTable = true;
                                                                     
                                                                        
                                                                      // selectedTable = false;
                                                                    
                                                                     });                            
                                                                        },
                                                                child: Text("Annuler"),
                                                                color: Colors.amber,
                                                                        )
                                                             */
                                        ],
                                      ),
                                   )));
                        }))),
                  );
                },
              ));
        });
  }
void showTicketDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              content: StatefulBuilder(
                  builder: (BuildContext, StateSetter setState) {
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
                                     if(order.orderType == selectedOrder){
                                          gettableNum (){
             for (TableModel T in listetable){
        if( T.id == order.tableId){
            return T.num;
        }
    }
} 

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
                                  /*  return Container(
                                    height: MediaQuery.of(context).size.height * 0.25, 
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      child: Column(
                                                        children: [
                                                          /* Image.asset(
                                                              "images/table.jpg",
                                                              fit: BoxFit.contain,
                                                              width:
                                                                  MediaQuery.of(context).size.width * 0.1,
                                                              height: MediaQuery.of(context).size.height *
                                                                  0.1,
                                                            ),  */
                                                            Text(
                                                             "Order #"+ order.id.toString(),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15),
                                                            ), 
                                                            if(order.tableId != null)
                                                            Text(
                                                             "Table"+ order.tableId.toString(),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15),
                                                            ), 
       
                                                            Text(
                                                             order.paymentStatus.toString(),
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
                                                    
                       ); */
                                })),
                              ],
                            ),
                          
                        ));
              }));
        });
  }


  void showRevenusDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: Revenus(), /* Revenus()*/
          );
        });
  }
    void _getTime() {
     final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now.toLocal());
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy HH:mm:ss').format(dateTime);
  }
}
