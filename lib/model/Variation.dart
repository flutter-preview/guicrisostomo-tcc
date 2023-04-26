import 'package:flutter/material.dart';
import 'package:tcc/globals.dart';
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

  void setProductItemSelected([String product = '', bool? value, bool isBusinessHighValue = false]) {
    
    productItemSelected.entries.forEach((element) {

      if (product == 'Não quero ${category.toLowerCase()}' || product == '') {
        productItemSelected[element.key] = false;
      } else {
        if (element.key.name == product) {
          productItemSelected[element.key] = value!;
        } else {
          if (limitItems == 1) {
            productItemSelected[element.key] = false;
          }
        }
      }
    });

    price = getPriceTotal(isBusinessHighValue);
  }

  bool getProductItemSelected(ProductItemList productItem) {
    if (productItemSelected[productItem] == null) {
      productItemSelected[productItem] = false;
    }

    return productItemSelected[productItem]!;
  }

  num getPriceTotal(bool isBusinessHighValue) {
    price = 0.0;

    if (isBusinessHighValue) {
      productItemSelected.entries.forEach((element) {
        if (element.value) {
          if (element.key.price > price) {
            price = element.key.price;
          }
        }
      });
    } else {
      productItemSelected.entries.forEach((element) {
        if (element.value) {
          price += element.key.price;
        }
      });

      price /= productItemSelected.length;
    }

    return price;
  }

  String returnAllText([bool isTextController = true]) {
    String text = '';

    if (!isTextController) {
      return value;
    }

    if (textController.isEmpty) {
      return text;
    }

    textController.entries.forEach((element) {
      if (element.value.text != '') {
        if (text != '') {
          text += ',';
        }

        text += element.value.text;
      }
    });

    if (text != '') {
      text = text.substring(0, text.length - 1);
    }

    return text;
  }
}