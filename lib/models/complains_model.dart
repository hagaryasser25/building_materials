import 'package:flutter/cupertino.dart';

class Complains {
  Complains({
    String? id,
    String? userEmail,
    String? description,
  }) {
    _id = id;
    _userEmail = userEmail;
    _description = description;
  }

  Complains.fromJson(dynamic json) {
    _id = json['id'];
    _userEmail = json['userEmail'];
    _description = json['description'];
  }

  String? _id;
  String? _userEmail;
  String? _description;
  

  String? get id => _id;
  String? get userEmail => _userEmail;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userEmail'] = _userEmail;
    map['description'] = _description;

    return map;
  }
}