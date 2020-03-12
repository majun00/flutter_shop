import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';

Future request(url, {formData}) async {
  try {
    print('开始获取数据......');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('服务器异常');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
