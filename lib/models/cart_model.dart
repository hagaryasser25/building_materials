import 'package:flutter/cupertino.dart';

class Cart {
  Cart({
    String? name,
    int? price,
    String? imageUrl,
    int? amount,
    int? total,
    String? id,
  }) {
    _name = name;
    _price = price;
    _imageUrl = imageUrl;
    _amount = amount;
    _total = total;
    _id = id;
  }

  Cart.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
    _imageUrl = json['imageUrl'];
    _amount = json['amount'];
    _total = json['total'];
    _id = json['id'];
  }

  String? _name;
  int? _price;
  String? _imageUrl;
  int? _amount;
  int? _total;
  String? _id;
  

  String? get name => _name;
  int? get price => _price;
  String? get imageUrl => _imageUrl;
  int? get amount => _amount;
  int? get total => _total;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['price'] = _price;
    map['imageUrl'] = _imageUrl;
    map['amount'] =_amount;
    map['total'] = _total;
    map['id'] = _id;

    return map;
  }
}