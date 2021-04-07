import 'package:flutter/material.dart';
class MyIconButton extends StatelessWidget {
 final EdgeInsetsGeometry margin;
 final double radius;
 final IconData icon;
 final Color iconColor;
 final Color circleColor;
 final Function action;
  MyIconButton(this.icon,this.iconColor,this.circleColor,this.margin,this.radius,{this.action});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: circleColor,
        child: IconButton(
          splashRadius: 25,
          icon: Icon(
            icon,
            size: 25,
            color: iconColor,
          ),
          onPressed:action ,
        ),
      ),
    );
  }
}
