// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/Screens/home.dart';
import 'package:flutter_caissenregistreuse_1/models/products.dart';
import 'package:flutter_caissenregistreuse_1/screens/login.dart';
import 'package:flutter_caissenregistreuse_1/widgets/cart.dart';
import 'package:flutter_caissenregistreuse_1/widgets/product1.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
//  import 'device_orientation/device_orientation_demo.dart';
void main() {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
   // DeviceOrientation.portraitUp,
   // DeviceOrientation.portraitDown,
   DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    
  ]).then((value) =>
  runApp(     MultiProvider(
     providers: [
      Provider<Product1>(create: (_) => Product1()),
       ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],child:MyApp(),
    ),));
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    //super.initState();
  }
  void _checkIfLoggedIn() async{
      // check if token is there
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      if(token!= null){
         setState(() {
            _isLoggedIn = true;
         });
      }
    
  }

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
     //  Scaffold(
    //  resizeToAvoidBottomInset : false,
      //  body:
    home:   _isLoggedIn ? Home() :  Login(),
           
    //  ),
      
    );
  }
}






 

     

