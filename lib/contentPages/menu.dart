import 'package:delivery_app/contentPages/checkoutPage.dart';
import 'package:delivery_app/contentPages/notesPage.dart';
import 'package:delivery_app/model/brandController.dart';
import 'package:delivery_app/transition/transition.dart';
import 'package:delivery_app/widgets/foodItem.dart';
import 'package:delivery_app/widgets/menuAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:scoped_model/scoped_model.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}


@override

double containerHeight=0;
class _MenuState extends State<Menu> {

  GlobalKey container = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModelDescendant(
          builder: (context, child, BrandController brand) {
            return CustomScrollView(slivers: [
              MenuAppBar(),
              SliverStickyHeader(
                sticky: false,
                header: Container(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      brand.brandModel[brand.getSpecificData()]
                          .categories['Category1'][0],
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return FoodItems(
                      name: brand.brandModel[brand.getSpecificData()]
                          .category1['foodName'][index],
                      description: brand.brandModel[brand.getSpecificData()]
                          .category1['foodInfo'][index],
                      image: brand.brandModel[brand.getSpecificData()]
                          .category1['foodImage'][index],
                      price: brand.brandModel[brand.getSpecificData()]
                          .category1['foodPrice'][index],
                      action: () {
                        brand.brandModel[brand.getSpecificData()]
                                    .category1['foodNote'][index] ==
                                true
                            ? Navigator.push(
                                context,
                                Transition.f(NotesPage(
                                    brand.brandModel[brand.getSpecificData()]
                                        .category1['foodName'][index],
                                    brand.brandModel[brand.getSpecificData()]
                                        .category1['foodPrice'][index])))
                            : brand.addToCart(
                                name: brand.brandModel[brand.getSpecificData()]
                                    .category1['foodName'][index],
                                price: brand.brandModel[brand.getSpecificData()]
                                    .category1['foodPrice'][index],
                          image:  brand.brandModel[brand.getSpecificData()]
                              .category1['foodImage'][index]
                              );
                        setState(() {
                          containerHeight=60;
                        });
                      });
                },
                        childCount: brand.brandModel[brand.getSpecificData()]
                            .category1['foodName'].length)),
              ),
              SliverStickyHeader(
                sticky: false,
                header: Container(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      brand.brandModel[brand.getSpecificData()]
                          .categories['Category2'][0],
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return FoodItems(
                      name: brand.brandModel[brand.getSpecificData()]
                          .category2['dessertName'][index],
                      description: brand.brandModel[brand.getSpecificData()]
                          .category2['dessertInfo'][index],
                      image: brand.brandModel[brand.getSpecificData()]
                          .category2['dessertImage'][index],
                      price: brand.brandModel[brand.getSpecificData()]
                          .category2['dessertPrice'][index],
                      action: () {
                        setState(() {
                         containerHeight=60;
                        });
                        brand.brandModel[brand.getSpecificData()]
                                    .category2['foodNote'][index] ==
                                true
                            ? Navigator.push(
                                context,
                                Transition.f(NotesPage(
                                    brand.brandModel[brand.getSpecificData()]
                                        .category2['dessertName'][index],
                                    brand.brandModel[brand.getSpecificData()]
                                        .category2['dessertPrice'][index])))
                            : brand.addToCart(
                                name: brand.brandModel[brand.getSpecificData()]
                                    .category2['dessertName'][index],
                                price: brand.brandModel[brand.getSpecificData()]
                                    .category2['dessertPrice'][index],
                          image: brand.brandModel[brand.getSpecificData()]
                              .category2['dessertImage'][index]
                              );
                      });
                },
                        childCount: brand.brandModel[brand.getSpecificData()]
                            .category2['dessertName'].length)),
              ),
            ]);
          },
        ),
        bottomNavigationBar:ScopedModelDescendant(
          builder: (context, child, BrandController brand) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (__) => CheckOutPage(brand))),
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.easeInOutCubic,
                  padding: EdgeInsets.only(right: 20),
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            brand.totalItems.toString(),
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${brand.subTotal}\$',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Go to checkout',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            );
          },
        ));
  }
}
