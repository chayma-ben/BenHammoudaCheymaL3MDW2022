import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';

class ingredients extends StatefulWidget {
  ingredients({Key? key,}) : super(key: key);

  @override
  State<ingredients> createState() => _ingredientsState();
}

class _ingredientsState extends State<ingredients> {
   var imgUrl = "http://192.168.1.12:8001/storage/ingredient/";

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Network().getDataAll("/ingredients"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Text("Loading..."),
            );
          } else {
            //print(snapshot.data);
            return Container(
               height:MediaQuery.of(context).size.height* 0.05,

              child:
              
               Wrap(
                 children: [
                     Row(
                                                    children: [
                                                      Text(
                                                        "Ingredients ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                   
                   Container(
                      height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.1,
                                                   
                                                  
                     child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                          final _isSelected= snapshot.data.contains(index);
                       // crossAxisCount: 4,
                        //children: List.generate(snapshot.data.length, (index) {
                          return /*Container(
                            color: Colors.amber,
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.05,
                              child: */
            
                                 GestureDetector(
                                   child: Container(
                                     color :  _isSelected ? Colors.red : null,

                                     padding: EdgeInsets.only(left: 20),
                                     child: Column(
                                        children: [
                                           Image.network(
                                            imgUrl + snapshot.data[index]['image'],
                                            fit: BoxFit.contain,
                                            width: MediaQuery.of(context).size.width * 0.04,
                                            height:
                                                MediaQuery.of(context).size.height * 0.04,
                                          ),
                                          Center(
                                            child: Text(snapshot.data[index]['name'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15)),
                                          ),
                                        ],
                                                                 //  ),
                                                                 
                                                              
                                                             
                                                           ),
                                   ),
                                 );
                        }),
                   ),
                 ],
               ),
            );
            
          }
        });
  }
}
