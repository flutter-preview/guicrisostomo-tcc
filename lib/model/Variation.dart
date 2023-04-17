import 'package:flutter/material.dart';

class Variation {
  int? id;
  String category;
  String size;
  num? price = 0;
  bool? isDropDown = false;
  int? limitItems = 0;
  bool? pricePerItem = false;
  bool isTextEmpty = true;
  String value = '';
  TextEditingController textController = TextEditingController();
  // Stream<bool> stream = Stream.value(true);
  // static Map<dynamic, dynamic> values = {};

  Variation({
    this.id = 0, 
    this.category = '', 
    this.size = '',
    this.price = 0,
    this.isDropDown = false,
    this.limitItems = 0,
    this.pricePerItem = false,
  });

  String getValues([bool isText = false]) {
    if (!isText) {
        return value;
    } else {
        return textController.text;
    }
  }

  void setValues(newValue) {

    value = newValue;
    textController.text = newValue;


    checkTextEmpty();
    
  }

  void checkTextEmpty() {

    isTextEmpty = true;

    
      if (value != '') {
        isTextEmpty = false;
      }
    
      if (textController.text != '') {
        isTextEmpty = false;
      }

  }
}