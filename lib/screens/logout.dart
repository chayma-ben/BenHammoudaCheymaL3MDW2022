
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/screens/login.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout>{
  String? name;
  @override
  void initState(){
 //   _loadUserData();
    super.initState();
  }
 /* _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('branch')!);
 if(user != null) {
    setState(() {
      name = user['name'];
    });
  }
 
} */

_save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
    @override
    Widget build(BuildContext context) {
        return 
           Container(
            //minWidth:40,
             //height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: 
                  IconButton(
                      onPressed: () {
                       // showLogoutDialog();
                        
                  logout();
                      },
                      
                      icon: Icon(Icons.logout, color: Colors.white,),
                       
                    ),
            
            
        );
      }

  void logout() async{
  var res = await Network().getData('/logout');
  var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Login()));
    }
  }
 /*  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
             
          ),
          content: logoutPopup(),
        );
      },
    );
  }*/

}




