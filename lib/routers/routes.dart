import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handle.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('页面没有找到');
    });

    router.define(detailsPage, handler: detailsHandler);
  }
}
