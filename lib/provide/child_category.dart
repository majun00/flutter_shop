import 'package:flutter/material.dart';
import '../model/category.dart';

//  ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list) {
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.comments = '';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
}
