import 'package:delivery_app/contentPages/checkoutPage.dart';
import 'package:delivery_app/model/brandController.dart';
import 'package:delivery_app/widgets/myIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class NotesPage extends StatefulWidget {
  final String name;
   double price;
  NotesPage(this.name,this.price);
  @override
  _NotesPageState createState() => _NotesPageState();
}
List<String> withOrNot=[];
class _NotesPageState extends State<NotesPage> {
  var check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade700,
      body: ScopedModelDescendant(builder:(context,child,BrandController brand){
        return Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        MyIconButton(
                          Icons.arrow_back_rounded,
                          Colors.black,
                          Colors.white.withOpacity(0.8),
                          EdgeInsets.only(left: 20),
                          25,
                          action: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.22),
                            child: Text(
                              widget.name,
                              style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.7,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45))),
                    child: GridView.builder(
                        padding: EdgeInsets.only(top: 15),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: brand.brandModel[brand.getSpecificData()].notes[0].length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 2,
                            crossAxisCount: 2),
                        itemBuilder: (context,index){
                          return  noteBox(
                              brand.brandModel[brand.getSpecificData()].notes[0]['note${index+1}'][0],//name
                              brand.brandModel[brand.getSpecificData()].notes[0]['note${index+1}'][1],//image
                              brand.brandModel[brand.getSpecificData()].notes[0]['note${index+1}'][2]//check
                              , (bool) {
                            setState(() {
                              brand.brandModel[brand.getSpecificData()].notes[0]['note${index+1}'][2]=!brand.brandModel[brand.getSpecificData()].notes[0]['note${index+1}'][2];
                              if(brand.brandModel[brand.getSpecificData()].notes[0]['note${index+1}'][2]==true){
                                withOrNot.add('Without ${brand.brandModel[brand.getSpecificData()].notes[0]['note${index+1}'][0]}');
                              }
                            });
                          });
                        })),
                Container(
                  color: Colors.grey[100],
                  height: MediaQuery.of(context).size.height*0.32,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 15),
                      physics: BouncingScrollPhysics(),
                      itemCount: brand.brandModel[brand.getSpecificData()].notes[1].length,
                      itemBuilder: (context,index){
                        return  extraNot(
                            brand.brandModel[brand.getSpecificData()].notes[1]['extra${index+1}'][0],//name
                            brand.brandModel[brand.getSpecificData()].notes[1]['extra${index+1}'][1],//price
                            brand.brandModel[brand.getSpecificData()].notes[1]['extra${index+1}'][2],//check
                                (bool) {
                          setState(() {
                            brand.brandModel[brand.getSpecificData()].notes[1]['extra${index+1}'][2] = !brand.brandModel[brand.getSpecificData()].notes[1]['extra${index+1}'][2];
                            if(brand.brandModel[brand.getSpecificData()].notes[1]['extra${index+1}'][2]==true){
                              withOrNot.add('${brand.brandModel[brand.getSpecificData()].notes[1]['extra${index+1}'][0]}');
                              widget.price+=brand.brandModel[brand.getSpecificData()].notes[1]['extra${index+1}'][1];
                            }
                          });
                        });
                      }),
                ),



              ],
            ),
          ),
        );
      },),
      bottomNavigationBar: ScopedModelDescendant(builder: (context,child,BrandController brand){
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            brand.addToCart(name: widget.name,price: widget.price,withOrNot: withOrNot);

          },
          onTapCancel: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0)),
            ),
            height: 50,
            child: Center(
              child: Text(
                'Add to Cart',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );
      },)
    );
  }

  extraNot(String name, var price, bool x, var action) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(value: x, onChanged: action),
          Text(
            name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 1.0, right: 13),
            child: Text(
              price.toString() + ' \$',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  noteBox(String name, String image, bool x, Function action) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Image(
                height: 80,
                image: NetworkImage(image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 9),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.yellow.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Checkbox(value: x, onChanged: action),
                    Text(
                      'Without',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
