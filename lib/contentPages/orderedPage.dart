import 'package:delivery_app/model/brandController.dart';
import 'package:delivery_app/navigationBar/homePage.dart';
import 'package:delivery_app/navigationBar/navigationBar.dart';
import 'package:delivery_app/transition/transition.dart';
import 'package:flutter/material.dart';

class OrderedPage extends StatelessWidget {
  final BrandController brand;
  OrderedPage(this.brand);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                size: 250,
                color: Colors.white,
              ),
              GestureDetector(
                onTap: ()=>Navigator.pushReplacement(context, Transition.s(NavigationBar())),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Go To Home page',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
