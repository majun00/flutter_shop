import 'package:flutter/material.dart';
import '../model/category.dart';

//  ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = []; // 商品列表
  int childIndex = 0; // 子类索引值
  String categoryId = '4'; // 大类ID
  String subId = ''; // 小类ID
  int page = 1; // 列表页数，当改变大类或者小类时进行改变
  String noMoreText = ''; // 显示更多的标识

  // 点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;
    subId = '';
    childIndex = 0;
    page = 1;
    noMoreText = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, String id) {
    subId = id;
    childIndex = index;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  // 增加Page的方法
  addPage() {
    page++;
  }

  // 改变noMoreText数据 
  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
