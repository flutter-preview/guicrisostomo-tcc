import 'package:flutter/material.dart';
import 'package:tcc/model/ProductItemList.dart';

class Variation {
  int? id;
  String category;
  String size;
  bool? isDropDown = false;
  int? limitItems = 0;
  num price = 0.0;
  bool? pricePerItem = false;
  String value = '';
  Map<int, TextEditingController> textController = {};
  Map<int, bool> isTextEmpty = {};
  Map<ProductItemList, bool> productItemSelected = {};
  List<Variation> subVariation = [];
  
  Variation({
    this.id = 0, 
    this.category = '', 
    this.size = '',
    this.isDropDown = false,
    this.limitItems = 0,
    this.pricePerItem = false,
    this.price = 0.0,
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
    productItemSelected[productItem] = false;
  }

  void setProductItemSelected([String product = '', bool? value]) {
    print('setProductItemSelected: $product, $value');

    productItemSelected.entries.forEach((element) {
      if (product == 'Não quero ${category.toLowerCase()}' || product == '') {
        productItemSelected[element.key] = false;
      } else {
        if (element.key.name == product) {
          productItemSelected[element.key] = true;
        } else {
          if (limitItems == 1) {
            productItemSelected[element.key] = false;
          } else {
            if (value != null) {
              productItemSelected[element.key] = value;
            } else {
              productItemSelected[element.key] = !productItemSelected[element.key]!;
            }
          }
        }
      }
    });

    getPriceTotal();
  }

  bool getProductItemSelected(ProductItemList productItem) {
    if (productItemSelected[productItem] == null) {
      productItemSelected[productItem] = false;
    }

    return productItemSelected[productItem]!;
  }

  num getPriceTotal() {
    price = 0.0;

    productItemSelected.entries.forEach((element) {
      if (element.value) {
        price += element.key.price;
      }
    });

    return price;
  }
}