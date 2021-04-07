
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class FoodItems extends StatelessWidget {
  final String name;
  final String description;
   var price;
  final String image;
  final Function action;
  FoodItems({this.name,this.price,this.image,this.description,this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        margin: EdgeInsets.only(left: 15, right: 15,bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        height: 126,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.values[4],
          children: [
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              height: 100,
              width: 105,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        image),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,),
                    ))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10,top: 5),
                  child: Text(
                    price.toString()+'\$',
                    style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.green.shade700,
                      minRadius: 15,
                      maxRadius: 20,
                      child: IconButton(icon: Icon(Icons.add,color: Colors.white,size: 25,),onPressed: action,),
                    )),
              ],
            )
          ],
        ));
  }
}
