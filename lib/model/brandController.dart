import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/model/brandModel.dart';
import 'package:delivery_app/model/cartModel.dart';
import 'package:scoped_model/scoped_model.dart';

class BrandController extends Model {
  List<BrandModel> _allBrandsModel = [];
  List<String> _allBrandsId = [];
  List<String> orders = [];
  List<CartModel> cart = [];
  double subTotal = 0.0;
  int totalItems = 0;

  List<BrandModel> get brandModel => _allBrandsModel;
  bool isGetDataLoading = true;

  getBrands() async {

      isGetDataLoading = true;
      notifyListeners();
      var value = await FirebaseFirestore.instance.collection('Brands').get();
      value.docs.forEach((i) {
        final BrandModel newModel = BrandModel(
          id: i.id,
          brandName: i['brandName'],
          brandInfo: i['brandInfo'],
          brandLogo: i['brandLogo'],
          brandBackImage: i['brandBackImage'],
          deliveryPrice: i['deliveryPrice'],
          categoryNumber: i['categoryNumber'],
          categories: i['Categories'],
          category1: i['category1'],
          category2: i['category2'],
          category3: i['category3'],
          category4: i['category4'],
          category5: i['category5'],
          notes: i['notes'],
        );
        if (_allBrandsModel.any((element) => element.id == newModel.id)) {
          return null;
        } else {
          _allBrandsModel.add(newModel);
          _allBrandsId.add(newModel.id);
        }
      });
      isGetDataLoading = false;
      notifyListeners();

  }

  addToCart(
      {double price, String name, int quantity = 1, List<String> withOrNot}) {
    try {
      var _cartItem = CartModel(
          itemPrice: price,
          itemName: name,
          quantity: quantity,
          withOrNot: withOrNot);

      if (cart.any((element) => element.itemName == name)) {
        cart[cart.indexWhere((element) => element.itemName == name)].quantity++;
        totalItems++;
      } else {
        cart.add(_cartItem);
        totalItems++;
      }
    } catch (e) {
      print(e + 'sds');
    }

    subTotal += price;
    notifyListeners();
  }

  getTotalPrice() {
    return subTotal+brandModel[getSpecificData()].deliveryPrice;
  }
  sortOrder(){
    cart.forEach((element) {
      orders.add(''''${element.quantity} x  ${element.itemName} ,
      ${element.withOrNot==null?'No notes':element.withOrNot.toString()}
      ''');
    });
  }
  addOrder(){
    sortOrder();
    Map<String,dynamic> _order={
      'Order':'${orders.toString()}'
    };
     FirebaseFirestore.instance.collection('Brands').doc('${_allBrandsModel[getSpecificData()].id}').collection('Order').add(_order);
  }

  int getSpecificData() {
    return brandModel.indexWhere((element) =>
        element.id == _allBrandsId[_allBrandsId.indexOf(element.id)]);
  }
}
