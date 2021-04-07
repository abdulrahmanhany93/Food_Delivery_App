import 'package:delivery_app/contentPages/menu.dart';
import 'package:delivery_app/model/brandController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  BrandController brand;
  HomePage(this.brand);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    widget.brand.getBrands();
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (context,child,BrandController brand){
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                child: Text(
                  'Home',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 250,
            ),
            SliverStickyHeader(
              sticky: false,
              header: Container(
                height: 60,
                margin: EdgeInsets.only(left: 17, right: 15, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  title: Text(
                    'Search',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.orange,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  leading: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.orange,
                  ),
                ),
              ),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Container(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        margin: EdgeInsets.only(left: 20, right: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 110,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20, left: 0),
                              height: 90,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        brand.brandModel[brand.getSpecificData()].brandLogo),
                                  )),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    brand.brandModel[brand.getSpecificData()].brandName,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      brand.brandModel[brand.getSpecificData()].brandInfo,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38,
                                      ),
                                    )),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child: CircleAvatar(
                                  backgroundColor: Colors.orange.shade500,
                                  minRadius: 15,
                                  maxRadius: 20,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    onPressed: () => Navigator.push(context,
                                        MaterialPageRoute(builder: (__) => Menu())),
                                  ),
                                )),
                          ],
                        ));
                  }, childCount: brand.brandModel.length)),
            ),
          ],
        ),
      );
    });
  }
}
