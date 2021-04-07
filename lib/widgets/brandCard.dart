import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final String brandName;
  final String brandInfo;
  final String brandLogo;
  final String deliveryTime;
  final String rate;
  final double deliveryCost;
  final Function changeAction;

  BrandCard(this.brandName, this.brandInfo, this.brandLogo, this.deliveryTime,
      this.deliveryCost, this.rate, this.changeAction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          ListTile(
            title: Text(
              brandName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              brandInfo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: CircleAvatar(
                radius: 25, backgroundImage: NetworkImage(brandLogo)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.delivery_dining,
                size: 30,
                color: Colors.green,
              ),
              Text(
                'Delivery Time ' + deliveryTime + ' min',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(15)),
                  child: MaterialButton(
                      child: Text(
                        'Change',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      onPressed: changeAction))
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Icon(
                Icons.thumb_up,
                size: 25,
                color: Colors.green,
              ),
              SizedBox(
                width: 28,
              ),
              Text(
                rate,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 27,
                height: 60,
              ),
              Icon(
                Icons.monetization_on,
                size: 30,
                color: Colors.green,
              ),
              SizedBox(
                width: 27,
              ),
              Text(
                'Delivery Cost $deliveryCost',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
