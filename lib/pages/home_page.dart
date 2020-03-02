import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '暂无数据';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('标题'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _jike,
                child: Text('按钮文案'),
              ),
              Text(showText)
            ],
          ),
        ),
      ),
    );
  }

  void _jike() {
    print('start request...');
    getHttp().then((val) {
      setState(() {
        showText = val['data'].toString();
      });
    });
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();

      dio.options.headers = httpHeaders;
      var params = {'test': 'test'};

      response = await dio.get('https://time.geekbang.org/serv/v1/column/newAll', queryParameters: params);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
