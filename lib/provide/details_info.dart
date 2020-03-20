import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../model/details.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  getGoodsInfo(String id) {
    var formData = {'goodId': id};
    request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      print(responseData);
      notifyListeners();
    });
  }
}
