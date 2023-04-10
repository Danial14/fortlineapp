import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier{
  List<Map<String, List<String>>> _productCategories = [];
  bool fetchAndAddProducts(){
    try{
     notifyListeners();
    }
    catch(e){
      print(e.toString());
    }
    return false;
  }
  List<Map<String, List<String>>> get getProductCategories{
    return [..._productCategories];
  }
}