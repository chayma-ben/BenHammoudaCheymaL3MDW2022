import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_caissenregistreuse_1/Screens/home.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:flutter_caissenregistreuse_1/models/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 // bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //var email, password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isObscure = true;
 var urlimage ="http://khazinav2.tannichm46.sg-host.com/storage/restaurant/";

  _showMsg(msg) {
    //
    /* final snackBar = SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    void checkPassword(BuildContext context, String passwordd) {
    if (passwordd !=  password) {
      final snackBar = SnackBar(content: Text("$password is not correct!"));
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }
  } */
    _showMsg(msg) { //
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  } 
   Restaurant? restau;
void initState() {
  
   Network(). fetchRestaurant().then((value) =>{
    setState( (){
restau = value;
    }),
  }); 
   
} 

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(45, 8, 50, 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (emailValue) {
          if (emailValue!.isEmpty) {
            return 'Veuillez entrer email';
          }

          //email = emailValue;
          //return null;
        },
        onChanged: (value) {
         // email = value;
        },
        controller: emailController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.black,
          ),
          labelText: 'Identifiant',
        ),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 8, 50, 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: _isObscure,
       enableSuggestions: false,
       autocorrect: false,
        onChanged: (value) {
          setState(() {
          //  password = value;
          });
        },
        validator: (passwordValue) {
          if (passwordValue!.isEmpty) {
            return 'Veuillez entrer mot de passe';
          }

         // password = passwordValue;
         // return null;
        },
        controller: passwordController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.black,
          ),

          labelText: 'Mot de passe',
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top:0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xff042940),
            child: IconButton(
                color: Colors.white,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                  FocusManager.instance.primaryFocus?.unfocus();

                },
                icon: Icon(
                  Icons.arrow_forward,
                )),
          )
        ],
      ),
    );
  }

  Widget _buildContainer() {

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

           Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[700]!,
                      offset: Offset(0, 0),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center ,
                      children: [
                    if(restau != null)
                         Image.network(urlimage + restau!.restaurantLogo!,
                                      fit: BoxFit.contain,
                                      height: MediaQuery.of(context).size.height * 0.1,

                            ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center ,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          _buildEmailRow(),
                          _buildPasswordRow(),
                        ])),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: _buildLoginButton(),
                    ),
                  ],
                ),
              ),


        ],

    );
  }

  @override
  Widget build(BuildContext context) {
  
     return GestureDetector(
         onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset : true,
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body:

                Stack(children: <Widget>[
                              Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Image.asset(
                    "images/pizza.png",
                    scale: 30,
                  ),
                              ),
                              Positioned(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: MediaQuery.of(context).size.width * 0.1,
                    child: Image.asset(
                      "images/milktea.png",
                      scale: 8,
                    )),
                              Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: Image.asset(
                    "images/fries.png",
                    scale: 25,
                  ),
                              ),
                              Positioned(
                    top: MediaQuery.of(context).size.height * 0.3,
                    left: MediaQuery.of(context).size.width * 0.1,
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: Image.asset(
                        "images/sandwich.png",
                        scale: 30,
                      ),
                    )),
                              Positioned(
                  top: MediaQuery.of(context).size.height * 0.83,
                  right: MediaQuery.of(context).size.width * 0.5,
                  child: Transform.rotate(
                    angle: -math.pi / 10,
                    child: Image.asset(
                      "images/wingfriedchicken.png",
                      scale: 25,
                    ),
                  ),
                              ),
                              Positioned(
                  top: MediaQuery.of(context).size.height * 0.83,
                  right: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset(
                    "images/donut.png",
                    scale: 10,
                  ),
                              ),
                              Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: MediaQuery.of(context).size.width * 0.01,
                  child: Transform.rotate(
                    angle: -math.pi / 10,
                    child: Image.asset(
                      "images/burger.png",
                      scale: 15,
                    ),
                  ),
                              ),
                              Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.09,
                  child: Transform.rotate(
                    angle: -math.pi / 10,
                    child: Image.asset(
                      "images/milkshake.png",
                      scale: 7,
                    ),
                  ),
                              ),
                              Positioned(
                  top: MediaQuery.of(context).size.height * 0.83,
                  left: MediaQuery.of(context).size.width * 0.1,
                  child: Transform.rotate(
                    angle: -math.pi / 10,
                    child: Image.asset(
                      "images/cupcake.png",
                      scale: 9,
                    ),
                  ),
                              ),
                              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.47,
                  left: MediaQuery.of(context).size.width * 0.1,
                  child: Transform.rotate(
                    angle: -math.pi / 100,
                    child: Image.asset(
                      "images/shape.png",
                      scale: 1,
                    ),
                  ),
                              ),
                              Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: MediaQuery.of(context).size.width * 0.50,
                  child: Image.asset(
                    "images/shape.png",
                    scale: 1,
                  ),
                              ),
                            
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildContainer(),
                    ],
                  ),
                            
                            ]),
                )



    );
  }

  void _login() async {
    /*setState(() {
      _isLoading = true;
    });*/

    var data = {'email': emailController.text, 'password': passwordController.text};
     print(data);
    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.setString('token', json.encode(body['token']));
      print(token);
      localStorage.setString('token', json.encode(body['token']));
      //var token1 = localStorage.setString('token', json.encode(body['token']));
         var resdata = await Network().postData(data, '/check');
    var bodydata = json.decode(resdata.body);
if(bodydata['success'] ==true)
{

    localStorage.setString('branch', json.encode(bodydata['branch']));
    localStorage.setString('branch-id', (bodydata['branch'][0]["id"]).toString() );
  
   // print(token1);
    
      }  

      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Home()),
      );
    } 
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Branche inconnue"),
      ));


    }

      


    /*setState(() {
      _isLoading = true;
    });*/
  }
}
