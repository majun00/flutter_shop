import 'package:flutter/material.dart';
import '../model/category.dart';

//  ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = []; // 商品列表
  int childIndex = 0; // 子类索引值
  String categoryId = '4'; // 大类ID
  String subId = ''; // 小类ID

  // 点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;
    subId = '';
    childIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.comments = '';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, String id) {
    childIndex = index;
    subId = id;
    notifyListeners();
  }
}
