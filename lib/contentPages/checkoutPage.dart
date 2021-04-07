import 'package:delivery_app/contentPages/orderedPage.dart';
import 'package:delivery_app/loading.dart';
import 'package:delivery_app/model/brandController.dart';
import 'package:delivery_app/transition/transition.dart';
import 'package:delivery_app/widgets/myIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class CheckOutPage extends StatefulWidget {
 final BrandController brand;
 CheckOutPage(this.brand);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List<Marker> markers = [];
  List<Polyline> poly = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),
      body: ScopedModelDescendant(
        builder: (context, child, BrandController brand) {
          return Container(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                          SizedBox(
                            width: 80,
                          ),
                          Text(
                            'CheckOut',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(
                      children: [
                        Container(
                            height: 300,
                            child: FutureBuilder(
                              future: checkMap(),
                              builder:
                                  (BuildContext context, AsyncSnapshot shot) {
                                if (shot.hasData == false) {
                                  return Loading();
                                } else {
                                  return shot.data;
                                }
                              },
                            )),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.3,
                            left: MediaQuery.of(context).size.width * 0.04,
                            right: MediaQuery.of(context).size.width * 0.04,
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.wrong_location_sharp,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    title: FutureBuilder(
                                      future: getAddress(),
                                      builder: (context, shot) {
                                        if (shot.hasData) {
                                          return Text(
                                            shot.data,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else {
                                          return Loading();
                                        }
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.delivery_dining,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                    title: Text(
                                      'Delivery Time 30-40 min',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.no_food,
                          color: Colors.yellow[700],
                          size: 30,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Your Order',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25)),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: brand.cart.isEmpty
                        ? Center(
                            child: Icon(
                            Icons.fastfood_outlined,
                            size: 60,
                            color: Colors.yellow.shade700,
                          ))
                        : ListView(
                            padding: EdgeInsets.only(top: 5),
                            children: List.generate(brand.cart.length, (index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: ListTile(
                                        leading: Image(
                                          image: NetworkImage(
                                              'https://i.pinimg.com/originals/30/dc/20/30dc20978c49920cae498aadcc33415c.jpg'
                                              ''),
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: brand
                                                        .cart[index].quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.black)),
                                                TextSpan(
                                                    text: 'x',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17,
                                                        color: Colors
                                                            .green.shade600)),
                                              ]),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              brand.cart[index].itemName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        trailing: Text(
                                          '${brand.cart[index].itemPrice} \$',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green.shade600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.credit_card_outlined,
                          color: Colors.yellow[700],
                          size: 30,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Payment Method',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Card Ending in 0257',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Change Card',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade600),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Discount code',
                                    labelStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[700],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  'Apply',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 25,
                          indent: 4,
                          endIndent: 4,
                          thickness: 1,
                        ),
                        chequeInfo(
                            'Subtotal', brand.subTotal, Colors.grey[700], 20),
                        chequeInfo('Service fee', 2, Colors.grey[700], 20),
                        chequeInfo(
                            'Delivery fee',
                            brand.brandModel[brand.getSpecificData()]
                                .deliveryPrice,
                            Colors.grey[700],
                            20),
                        chequeInfo(
                            'Total', brand.getTotalPrice(), Colors.black, 25),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, Transition.f(OrderedPage(brand)));
                            brand.addOrder();
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade700,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Place order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  chequeInfo(String text, double price, Color textColor, double textSize) {
    return Container(
      height: 50,
      child: ListTile(
        leading: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: textSize),
        ),
        trailing: Text(
          '$price \$',
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: textSize),
        ),
      ),
    );
  }

  checkMap() async {
    try {
      bool _enabled = await Geolocator.isLocationServiceEnabled();
      Position _currentPosition = await Geolocator.getCurrentPosition();
      if (_enabled == false) {
        return Text('Please Enable Gps');
      } else {
        Marker newMarker = Marker(
          markerId: MarkerId('1'),
          position: LatLng(30.013056, 31.208853),
        );
        Marker newMarker2 = Marker(
          markerId: MarkerId('2'),
          position: LatLng(29.995121871385837, 31.211878879551808),
        );
        var p = Polyline(
            polylineId: PolylineId('a'),
            points: [
              LatLng(29.995121871385837, 31.211878879551808),
              LatLng(30.013056, 31.208853),
            ],
            color: Colors.red);
        setState(() {
          poly.add(p);
          markers.add(newMarker);
          markers.add(newMarker2);
        });
        return buildMap(30.013056, 31.208853);
      }
    } catch (e) {
      print(e);
    }
  }

  getAddress() async {
    var x = await GeolocatorPlatform.instance.getCurrentPosition();
    var coordinates = Coordinates(x.latitude, x.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first.featureName;
  }

  buildMap(double lat, double long) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        zoom: 12,
        target: LatLng(lat, long),
      ),
      zoomControlsEnabled: false,
      scrollGesturesEnabled: true,
      mapType: MapType.terrain,
      markers: Set.from(markers),
      polylines: Set.from(poly),
    );
  }
}
