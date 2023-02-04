import 'package:flutter/cupertino.dart';

class Replays {
  Replays({
    String? id,
    String? userEmail,
    String? description,
    String? userComplain,
  }) {
    _id = id;
    _userEmail = userEmail;
    _description = description;
    _userComplain = userComplain;
  }

  Replays.fromJson(dynamic json) {
    _id = json['id'];
    _userEmail = json['userEmail'];
    _description = json['description'];
    _userComplain = json['userComplain'];
  }

  String? _id;
  String? _userEmail;
  String? _description;
  String? _userComplain;

  String? get id => _id;
  String? get userEmail => _userEmail;
  String? get description => _description;
  String? get userComplain => _userComplain;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userEmail'] = _userEmail;
    map['description'] = _description;
    map['userComplain'] = _userComplain;

    return map;
  }
}
