/* import 'package:flutter/material.dart';
import 'package:flutter_caissenregistreuse_1/api/api.dart';

class Restaurant extends StatefulWidget {
  Restaurant({Key? key}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  @override
var restaurant = <Restaurant>[];
  void initState(){
    super.initState();
     Network().fetchRestaurant().then((value) => {
                                
                         setState(() {
                    restaurant.addAll(value);
print(restaurant);

                         })
                                  }) ;
  }
  Widget build(BuildContext context) {
    print(restaurant);
    return Container();
  }
} */