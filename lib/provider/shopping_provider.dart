import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../model/shopping_card_model.dart';

final List<ShoppingCardModel> initialData = List.generate(
    50, (index) => ShoppingCardModel(
    "Brand $index",
    "${Random().nextInt(100) + 100} TL",
    "https://picsum.photos/200"));


class ShoppingProvider extends ChangeNotifier{

  final List<ShoppingCardModel> _shoppingList = initialData;
  List<ShoppingCardModel> get shoppingList => _shoppingList;

  final List<ShoppingCardModel> _saveList = [];
  List<ShoppingCardModel> get saveList => _saveList;

  void addToList(ShoppingCardModel shoppingCardModel){
    _saveList.add(shoppingCardModel);
    notifyListeners();
  }
  void removeFromList(ShoppingCardModel shoppingCardModel){
    _saveList.remove(shoppingCardModel);
    notifyListeners();
  }
  bool _isVisible =false;
  bool get isVisible =>_isVisible;

  void changeVisible(){
    _isVisible !=_isVisible;
    notifyListeners();
  }

}