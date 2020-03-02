import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';

Future getHomePageContent() async {
  try {
    print('requese begin...');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    var formData = {'test': 'test'};
    response = await dio.post(servicePath['homePageContext'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('请求异常');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
