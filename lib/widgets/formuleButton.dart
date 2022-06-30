import 'package:flutter/material.dart';

class FormuleButton extends StatelessWidget {
   final Function(int) OnTap;
  const FormuleButton({Key? key, required this.OnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
                                     padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          left: 15,
                                     ),
                                     child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                               this.OnTap(5);
                                
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffFAFCFE),
                                ),
                                child: Row(
                                  children: [
                                    /* Image.network(
                                      ImageUrl + category.image!,
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width * 0.04,
                                      height:
                                          MediaQuery.of(context).size.height * 0.04,
                                    ), */
                                    Center(
                                      child: Text("formule",
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
                                   );;
  }
}