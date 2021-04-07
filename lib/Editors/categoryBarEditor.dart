import 'package:delivery_app/model/brandController.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoryBar extends StatefulWidget {

  CategoryBar();

  @override
  _CategoryBarState createState() => _CategoryBarState();
}

Map categories = {
  0: [
    'Burger',
    'https://image.similarpng.com/very-thumbnail/2020/04/Craft-beef-burger-with-cheese-png.png'
  ],
  1: [
    'Dessert',
    'https://e7.pngegg.com/pngimages/412/52/png-clipart-cheesecake-mikkelsen-s-pastry-shop-vegetarian-cuisine-food-cake.png'
  ],
  2: [
    'Combo',
    'https://image.similarpng.com/very-thumbnail/2020/04/Craft-beef-burger-with-cheese-png.png'
  ]
};
var selector = categories[0];

class _CategoryBarState extends State<CategoryBar> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context,child,BrandController brand){
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brand.brandModel[brand.getSpecificData()].categories.keys.length,
            itemBuilder: (context, index) {
              return categoryBar(
                  brand.brandModel[brand.getSpecificData()].categories['Category${index+1}'][0],
                  brand.brandModel[brand.getSpecificData()].categories['Category${index+1}'][1],
                  selector == brand.brandModel[brand.getSpecificData()].categories['Category${index+1}']
                      ? Colors.green.shade700
                      : Colors.grey[50], action: () {
                setState(() {
                  selector = brand.brandModel[brand.getSpecificData()].categories['Category${index+1}'];
                });
              });
            });
      },
    );
  }

  categoryBar(String category, String image, Color backColor,
      {Function action, Color textColor}) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
        width: 150,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(35)),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(image),
          ),
          title: Text(
            category,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
