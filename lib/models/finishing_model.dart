import 'package:flutter/cupertino.dart';

class FinishingMaterials {
  FinishingMaterials({
    String? name,
    int? price,
    String? description,
    String? company,
    int? amount,
    String? id,
    String? imageUrl,
  }) {
    _name = name;
    _price = price;
    _description = description;
    _company = company;
    _amount = amount;
    _id = id;
    _imageUrl = imageUrl;
  }

  FinishingMaterials.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
    _description = json['description'];
    _company = json['companyName'];
    _amount = json['amount'];
    _id = json['id'];
    _imageUrl = json['imageUrl'];
  }

  String? _name;
  int? _price;
  String? _description;
  String? _company;
  int? _amount;
  String? _id;
  String? _imageUrl;

  String? get name => _name;
  int? get price => _price;
  String? get description => _description;
  String? get company => _company;
  int? get amount => _amount;
  String? get id => _id;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['price'] = _price;
    map['description'] = _description;
    map['companyName'] = _company;
    map['amount'] = _amount;
    map['id'] = _id;
    map['imageUrl'] = _imageUrl;

    return map;
  }
}
