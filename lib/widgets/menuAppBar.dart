import 'package:delivery_app/Editors/categoryBarEditor.dart';
import 'package:delivery_app/model/brandController.dart';
import 'package:delivery_app/widgets/SABT.dart';
import 'package:delivery_app/widgets/brandCard.dart';
import 'package:delivery_app/widgets/myIconButton.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class MenuAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (context,child,BrandController brand){
      return SliverAppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          pinned: true,
          expandedHeight: 340,
          toolbarHeight: 80,
          actions: pinnedBar(context),
          backgroundColor: Colors.yellow.shade700,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          flexibleSpace: FlexibleSpaceBar(
            title: SABT(
              child: Text(
                brand.brandModel[brand.getSpecificData()].brandName,
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            collapseMode: CollapseMode.pin,
            stretchModes: [StretchMode.fadeTitle],
            centerTitle: true,
            background: Container(
              color: Colors.grey[200],
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 80),
                      child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(25)),
                          child: Image(
                            image: NetworkImage(
                              brand.brandModel[brand.getSpecificData()].brandBackImage),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: 160,
                    height: 220,
                    child: BrandCard(
                        brand.brandModel[brand.getSpecificData()].brandName,
                        brand.brandModel[brand.getSpecificData()].brandInfo,
                        brand.brandModel[brand.getSpecificData()].brandLogo,
                        '30-40',
                        brand.brandModel[brand.getSpecificData()].deliveryPrice,
                        'Excellent 9.2',
                            () {}),
                  ),
                ],
              ),
            ),
          ));
    });

  }
  pinnedBar(BuildContext context) {
    return [
      MyIconButton(
        Icons.arrow_back_rounded,
        Colors.black,
        Colors.white70,
        EdgeInsets.only(),
        25,
        action: () => Navigator.pop(context),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
      ),
      MyIconButton(Icons.search_outlined, Colors.black, Colors.white70,
          EdgeInsets.only(right: 20), 25),
    ];
  }
}

class CustomCategoryBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(color: Colors.grey[100], child: CategoryBar());
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 70;

  @override
  // TODO: implement minExtent
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}