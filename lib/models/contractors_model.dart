import 'package:flutter/cupertino.dart';

class Contractors {
  Contractors({
    String? name,
    String? phoneNumber,
    String? description,
    String? company,
    String? code,
    String? id,
  }) {
    _name = name;
    _phoneNumber = phoneNumber;
    _description = description;
    _company = company;
    _code = code;
    _id = id;
  }

  Contractors.fromJson(dynamic json) {
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    _description = json['description'];
    _company = json['companyName'];
    _code = json['code'];
    _id = json['id'];
  }

  String? _name;
  String? _phoneNumber;
  String? _description;
  String? _company;
  String? _code;
  String? _id;
  

  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  String? get description => _description;
  String? get company => _company;
  String? get code => _code;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['description'] = _description;
    map['companyName'] = _company;
    map['code'] = _code;
    map['id'] = _id;

    return map;
  }
}