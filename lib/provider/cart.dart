import 'package:flower_app/models/product.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List selectedproducts = [];
  double price = 0;

  add(Items products) {
    selectedproducts.add(products);
    price += products.price;
    notifyListeners();
  }

  delete(Items products) {
    selectedproducts.remove(products);
    price -= products.price;
    notifyListeners();
  }
}
