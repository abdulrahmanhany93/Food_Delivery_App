import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delivery_app/model/brandController.dart';
import 'package:delivery_app/navigationBar/clientProfile.dart';
import 'package:delivery_app/navigationBar/homePage.dart';
import 'package:delivery_app/navigationBar/location.dart';
import 'package:delivery_app/navigationBar/shoppingCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  var controller = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.orange.shade500,
          index: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              controller.animateToPage(index,
                  duration: Duration(milliseconds: 350),
                  curve: Curves.decelerate);
            });
          },
          height: 50,
          animationCurve: Curves.decelerate,
          animationDuration: Duration(milliseconds: 350),
          items: [
            Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 30,
            ),
            Icon(Icons.shopping_cart, color: Colors.white, size: 30),
            Icon(FontAwesomeIcons.locationArrow, color: Colors.white, size: 25),
            Icon(Icons.person, color: Colors.white, size: 30),
          ],
        ),
        body: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              ScopedModelDescendant(builder: (context,child,BrandController brand){
                return Container(child: HomePage(brand));
              },),
              ShoppingCart(),
              Location(),
              ClientProfile()
            ]));
  }
}
