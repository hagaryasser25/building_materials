import 'package:flutter/cupertino.dart';

class ContractListv {
  ContractListv({
    String? address,
    int? date,
    String? description,
    String? userEmail,
    String? code,
    String? id,
    String? deliveryDate,
    String? email,
  }) {
    _address = address;
    _date = date;
    _description = description;
    _userEmail = userEmail;
    _code = code;
    _id = id;
    _deliveryDate = deliveryDate;
    _email = email;
  }

  ContractListv.fromJson(dynamic json) {
    _address = json['address'];
    _date = json['date'];
    _description = json['description'];
    _userEmail = json['userEmail'];
    _code = json['code'];
    _id = json['id'];
    _deliveryDate = json['deliveryDate'];
    _email = json['email'];
  }

  String? _address;
  int? _date;
  String? _description;
  String? _userEmail;
  String? _code;
  String? _id;
  String? _deliveryDate;
  String? _email;

  String? get address => _address;
  int? get date => _date;
  String? get description => _description;
  String? get userEmail => _userEmail;
  String? get code => _code;
  String? get id => _id;
  String? get deliveryDate => _deliveryDate;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['date'] = _date;
    map['description'] = _description;
    map['userEmail'] = _userEmail;
    map['code'] = _code;
    map['id'] = _id;
    map['deliveryDate'] = _deliveryDate;
    map['email'] = _email;

    return map;
  }
}
