class CartModel {
  String itemName;
  int quantity;
  var itemPrice;
  String itemImage;
  List<String> withOrNot=[];


  CartModel({this.quantity, this.itemPrice,this.itemImage, this.itemName,this.withOrNot});


}
