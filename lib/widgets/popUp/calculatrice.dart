import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/widgets/cart.dart';
import 'package:flutter_caissenregistreuse_1/globals.dart' as globals;
import 'package:http/http.dart';

class Calculatrice extends StatefulWidget {
  @override
  _AddTwoNumbersState createState() => _AddTwoNumbersState();
}
 
class _AddTwoNumbersState extends State<Calculatrice> {
    



  var num1controller = globals.product;

 TextEditingController num2controller = new TextEditingController();
  String resulttext = "0";

  @override
  Widget build(BuildContext context) {
    return Container(

         width: MediaQuery.of(context).size.width*0.2,
     height: MediaQuery.of(context).size.height*0.2,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             Text(num1controller.toString() ),
             
            ],
          ),
          Row(
            children: <Widget>[
              Text(""),
               new Flexible(
                child: new TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
  ],
                  controller: num2controller,
                ),
              ), 

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
         
              RaisedButton(
                child: Text("="),
                onPressed : () {
                    double result = double.parse(num2controller.text) - double.parse(num1controller) ;

                  setState(() {
                    resulttext = result.toString();
                  });
                },
              ),
      
           
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               new Text(resulttext,
                 style: TextStyle(
                  fontSize: 30,
               ),),
            ],
          ),
        ],
      ),
      
    );
  }
}
