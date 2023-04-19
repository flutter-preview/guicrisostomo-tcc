import 'package:flutter/material.dart';
import 'package:tcc/model/ProductItemList.dart';

class Variation {
  int? id;
  String category;
  String size;
  bool? isDropDown = false;
  int? limitItems = 0;
  bool? pricePerItem = false;
  String value = '';
  Map<int, TextEditingController> textController = {};
  Map<int, bool> isTextEmpty = {};
  Map<ProductItemList, bool> productItemSelected = {};

  Variation({
    this.id = 0, 
    this.category = '', 
    this.size = '',
    this.isDropDown = false,
    this.limitItems = 0,
    this.pricePerItem = false,
  });

  String getValues([int index = -1]) {
    if (index == -1) {
      return value;
    }

    return textController[index]!.text;
  }

  void setValues(newValue, [int index = -1]) {
    if (index == -1) {
    value = newValue;
    } else {
      textController[index]!.text = newValue;
    }

    checkTextEmpty(index);
    
  }

  void checkTextEmpty(int index) {

    isTextEmpty[index] = true;
    
    if (value != '') {
      isTextEmpty[index] = false;
    }
  
    if (getValues(index) != '') {
      isTextEmpty[index] = false;
    }

  }

  void addValue(int id) {
    textController[id] = TextEditingController();
    isTextEmpty[id] = true;
  }

  TextEditingController getTextController(int index) {
    if (textController[index] == null) {
      addValue(index);
    }

    return textController[index]!;
  }

  void addProductItem(ProductItemList productItem) {
    if (productItemSelected[productItem] == null) {
      productItemSelected[productItem] = false;
    }
  }

  void setProductItemSelected(String product, bool value) {
    productItemSelected.entries.forEach((element) {
      if (element.key.name == product) {
        productItemSelected[element.key] = value;
      }
    });
  }

  bool getProductItemSelected(ProductItemList productItem) {
    if (productItemSelected[productItem] == null) {
      productItemSelected[productItem] = false;
    }

    return productItemSelected[productItem]!;
  }
}